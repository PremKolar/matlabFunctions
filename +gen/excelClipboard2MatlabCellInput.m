% NK
%% input
input = clipboard('paste');
%% get num tabs
sinput = string(input);
sinput = sinput.splitlines;
numfields = numel(regexp(sinput(1,:),'\t'))+1;
%% scan
C = textscan(input,repmat('%s ',1,numfields),'Delimiter','\t');

cb  = '';
cb = [ cb sprintf(' {\n')];
for y=1:numel(C{1})
    for x=1:numel(C)
        
        cb = [ cb sprintf('''%s'' ', char(C{x}(y)))]; %#ok<*AGROW>
    end
    cb = [ cb sprintf('\n')];
end
cb = [ cb sprintf('};\n')];
%%
fprintf(cb)
fprintf('\n sending to clipboard..\n')
clipboard('copy',cb)