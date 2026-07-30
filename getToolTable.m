function toolTable = getToolTable(toolIDs)
% getToolTable returns a summary table for a list of tool IDs
% Columns: ID, Name, Category, DomainTitle, DomainDescription

% Handle cell array input
if ~iscell(toolIDs)
    error('Input must be a cell array of tool IDs');
end

% Preallocate arrays
n = numel(toolIDs);
IDs = cell(n,1);
Names = cell(n,1);
Categories = cell(n,1);
DomainTitles = cell(n,1);
DomainDescriptions = cell(n,1);

% Fill arrays using getToolInfo
for i = 1:n
    info = getToolInfo(toolIDs{i});
    IDs{i} = info.ID;
    Names{i} = info.Name;
    Categories{i} = info.Category;
    DomainTitles{i} = info.Domain.Title;
    DomainDescriptions{i} = info.Domain.Description;
end

% Build table
toolTable = table(IDs, Names, Categories, DomainTitles, DomainDescriptions);
end
