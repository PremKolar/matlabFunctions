function out = popUpValue(popUp)    
    assert(isa(popUp, 'matlab.ui.control.UIControl'));
    try
        if ~iscell(popUp.String)
            out = popUp.String;
        else
            out = popUp.String{popUp.Value};
        end
    catch
        out = [];
    end
end