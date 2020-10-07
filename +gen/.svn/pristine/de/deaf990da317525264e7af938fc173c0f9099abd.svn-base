% NK
function deleteAllTxtsFromAxis(ax)
    arrayfun(@delete,ax.Children(strcmp('matlab.graphics.primitive.Text',arrayfun(@class,ax.Children,'UniformOutput',false))));
end