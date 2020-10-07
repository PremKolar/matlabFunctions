classdef (ConstructOnLoad) eventDataOfEvdata < event.EventData
    properties
        Indices
        OldValue
        NewValue
    end
    
    methods
        function data = eventDataOfEvdata(evdata)            
%             data.EventName = evdata.Style;
            data.OldValue = evdata.OldValue;
            data.NewValue = evdata.NewValue;
            data.Indices = evdata.Indices;
        end
    end
end