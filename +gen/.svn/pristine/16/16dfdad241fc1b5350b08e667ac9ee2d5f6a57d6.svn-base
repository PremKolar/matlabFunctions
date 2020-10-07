% Current date   = January 30, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function setPopUpToValidValue(popup)
    validateattributes(popup,{'matlab.ui.control.UIControl'},{'scalar'})
    assert(strcmp(popup.Style,'popupmenu'))
    try
        v = gen.popUpValue(popup);
        assert(~isempty(v));
    catch
        idx = max([find(~gen.isempty(popup.String),1),1]);
        popup.Value = idx;
    end
end