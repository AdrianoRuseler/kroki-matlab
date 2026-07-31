function activityInfo = getGitHubRepoActivity(owner, repo, token)
% GETGITHUBREPOACTIVITY Retrieves repository activity metrics from the GitHub REST API.
%
% Syntax:
%   activityInfo = getGitHubRepoActivity(owner, repo)
%   activityInfo = getGitHubRepoActivity(owner, repo, token)
%
% Inputs:
%   owner - (string/char) Repository owner or organization (e.g., 'mathworks')
%   repo  - (string/char) Repository name (e.g., 'MATLAB-language')
%   token - (Optional string/char) GitHub Personal Access Token (PAT) 
%           Recommended to avoid HTTP 403 rate-limiting (60 req/hr unauth vs 5000 req/hr auth).
%
% Output:
%   activityInfo - Struct containing repository activity statistics and details.
% https://github.com/mermaid-js/mermaid
% owner= 'mermaid-js'
% repo='mermaid'

    arguments
        owner (1,1) string
        repo (1,1) string
        token (1,1) string = ""
    end

    % Base API URL
    baseUrl = "https://api.github.com";

    % Configure HTTP headers (GitHub API requires a User-Agent header)
    headers = {'User-Agent', 'MATLAB-GitHubActivityFetcher'; ...
               'Accept', 'application/vnd.github.v3+json'};
    
    if strlength(token) > 0
        headers = [headers; {'Authorization', sprintf('Bearer %s', token)}];
    end
    
    opts = weboptions('HeaderFields', headers, 'Timeout', 15);
    activityInfo = struct();

    try
        %% 1. Repository Metadata & General Activity Counters
        repoUrl = sprintf('%s/repos/%s/%s', baseUrl, owner, repo);

        repoData = webread(repoUrl, opts);

        activityInfo.Repository         = string(repoData.full_name);
        activityInfo.Description        = string(repoData.description);
        activityInfo.Stars              = repoData.stargazers_count;
        activityInfo.Forks              = repoData.forks_count;
        activityInfo.OpenIssuesAndPRs   = repoData.open_issues_count;
        activityInfo.Watchers           = repoData.subscribers_count;
        activityInfo.DefaultBranch      = string(repoData.default_branch);
        activityInfo.CreatedAt          = string(repoData.created_at);
        activityInfo.UpdatedAt          = string(repoData.updated_at);
        activityInfo.PushedAt           = string(repoData.pushed_at);

        % Calculate days since last push
        pushedDt = datetime(repoData.pushed_at, 'InputFormat', "yyyy-MM-dd'T'HH:mm:ss'Z'", 'TimeZone', 'UTC');
        activityInfo.DaysSinceLastPush = round(days(datetime('now', 'TimeZone', 'UTC') - pushedDt));

        %% 2. Recent Commit Activity
        commitsUrl = sprintf('%s/repos/%s/%s/commits?per_page=10', baseUrl, owner, repo);
        commitsData = webread(commitsUrl, opts);

        if ~isempty(commitsData)
            % Normalize response struct/cell
            if iscell(commitsData)
                commitsData = [commitsData{:}];
            end
            
            activityInfo.LastCommitDate    = string(commitsData(1).commit.committer.date);
            activityInfo.LastCommitAuthor  = string(commitsData(1).commit.author.name);
            activityInfo.LastCommitMessage = string(commitsData(1).commit.message);
        else
            activityInfo.LastCommitDate    = "N/A";
            activityInfo.LastCommitAuthor  = "N/A";
            activityInfo.LastCommitMessage = "N/A";
        end

        %% 3. Latest Release Info
        try
            releaseUrl = sprintf('%s/repos/%s/%s/releases/latest', baseUrl, owner, repo);
            latestRelease = webread(releaseUrl, opts);
            
            activityInfo.LatestReleaseTag         = string(latestRelease.tag_name);
            activityInfo.LatestReleasePublishedAt = string(latestRelease.published_at);
            activityInfo.LatestReleaseName        = string(latestRelease.name);
        catch
            % Captures 404 error if no releases exist
            activityInfo.LatestReleaseTag         = "No releases found";
            activityInfo.LatestReleasePublishedAt = "N/A";
            activityInfo.LatestReleaseName        = "N/A";
        end

        %% 4. Annual & Monthly Commit Trends
        try
            statsUrl = sprintf('%s/repos/%s/%s/stats/commit_activity', baseUrl, owner, repo);
            commitStats = webread(statsUrl, opts);
            
            if iscell(commitStats)
                commitStats = [commitStats{:}];
            end

            if ~isempty(commitStats) && isfield(commitStats, 'total')
                totals = [commitStats.total];
                activityInfo.CommitsLastYearTotal  = sum(totals);
                activityInfo.CommitsLast4Weeks     = sum(totals(end-3:end));
            else
                activityInfo.CommitsLastYearTotal  = "Stats computing (re-run query)";
                activityInfo.CommitsLast4Weeks     = "Stats computing (re-run query)";
            end
        catch
            activityInfo.CommitsLastYearTotal  = "Unavailable";
            activityInfo.CommitsLast4Weeks     = "Unavailable";
        end

    catch ME
        error('getGitHubRepoActivity:FetchFailed', ...
            'Failed to fetch activity metrics for %s/%s. Error: %s', owner, repo, ME.message);
    end
end
