
function out = fname2pulldown(files)
    out = regexprep(files,'.*(/|\\)','');
end