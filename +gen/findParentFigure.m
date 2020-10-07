
function parent = findParentFigure(child)
    parent = child.Parent;
    if strcmp(parent.Type,'figure')
        return
    end
    parent = gen.findParentFigure(parent);
end
