% NK: TODO: This should not be in +gen
% OBSOLETE NOW
function Thrustratings(obj,RunType)
% Create Ratings for Test-cell application
%   Detailed explanation goes here
switch RunType
    case 0
    switch  obj.Data.Engine
        case 'CFM56-5A'
            obj.Data.TestCell.SchubRatings = {'TO_A1' 'MC_A1' 'TO_A3' 'MC_A3' 'TO_A4' 'MC_A4' 'TO_A5' 'MC_A5' 'TO_A1F' 'MC_A1F' 'TO_A5F' 'MC_A5F'};
        case 'CFM56-5B'
            obj.Data.TestCell.SchubRatings = {'TO_B1' 'MC_B1' 'TO_B3'    'MC_B3'    'TO_B47'    'MC_B47'    'TO_B5'    'MC_B5'    'TO_B6'    'MC_B6'};
        case 'CFM56-7B'
            obj.Data.TestCell.SchubRatings = {'TO_B27' 'MC_B27' 'TO_B26' 'MC_B26' 'TO_B24' 'MC_B24' 'TO_B22' 'MC_B22' 'TO_B20' 'MC_B20' 'TO_B18' 'MC_B18'};
        case 'CFM56-5C'
            obj.Data.TestCell.SchubRatings = {'TO_C2'    'MC_C2'    'TO_C3'    'MC_C3'    'TO_C4'    'MC_C4'};
        case {'V2500' 'PW1100G-JM' 'PW1500G'}
            obj.Data.TestCell.SchubRatings = {'A'    'B'    'C'    'D'   };
        case 'GENx-2B'
            obj.Data.TestCell.SchubRatings = {'TO' 'MC'};
        case 'CF6-80C2'
            obj.Data.TestCell.SchubRatings = {'TO_A1' 'MC_A1' 'TO_A2' 'MC_A2' 'TO_A3' 'MC_A3' 'TO_A5' 'MC_A5' 'TO_A8' 'MC_A8' 'TO_A5F' 'MC_A5F' 'TO_B1' 'MC_B1' 'TO_B2' 'MC_B2' 'TO_B4' 'MC_B4' 'TO_B6' 'MC_B6' 'TO_B1F' 'MC_B1F' 'TO_B2F' 'MC_B2F' 'TO_B4F' 'MC_B4F' 'TO_B5F' 'MC_B5F' 'TO_B6F' 'MC_B6F' 'TO_B6FA' 'MC_B6FA' 'TO_B7F' 'MC_B7F' 'TO_B8F' 'MC_B8F' 'TO_D1F' 'MC_D1F'};
    end
    case 1
        obj.Data.TestCell.SchubRatings = {'TO' 'CR280' 'CR290' 'CR300' 'CR310' 'CR320' 'CR330' 'CR340' 'CR350' 'CR360' 'CR370' 'CR380' 'CR390' 'CR400'};
end
end
obj.Data.TestCell.SchubRatingsWithIdle    = [obj.Data.TestCell.SchubRatings         'FI' 'GI'];
obj.Data.TestCell.SchubRatingsWithIdleGen = [obj.Data.TestCell.SchubRatingsWithIdle 'TO' 'MC'];
%Ausnahmen
switch  obj.Data.Engine % MUSTER
    case {'V2500' 'PW1100G-JM' 'PW1500G'} %keine TO- und MC-Ratings
        obj.Data.TestCell.SchubRatingsWithIdleGen = obj.Data.TestCell.SchubRatingsWithIdle;
    case 'GENx-2B' %keine Idle-Daten
        obj.Data.TestCell.SchubRatingsWithIdle    = obj.Data.TestCell.SchubRatings;
        obj.Data.TestCell.SchubRatingsWithIdleGen = obj.Data.TestCell.SchubRatings;
end

end
