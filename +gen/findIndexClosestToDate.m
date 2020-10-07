% NK
% can handle datenums too if silent
function [index,timedistToDate,actualDate] = findIndexClosestToDate(dateVector,date,preOrPost,silent,allAtDate)
    if nargin<4 || ~silent
        validateattributes(dateVector,{'datetime' 'double' 'gen.qatetime'},{'vector', 'nonempty'})
        validateattributes(date,{'datetime'  'double'  'gen.qatetime'},{'scalar', 'nonempty'})
        validateattributes(preOrPost,{'char'},{'row', 'nonempty'})
        assert(ismember(preOrPost,{'pre','post'}))
    end
    if nargin<5
        allAtDate = false;
    end
    diff = (datenum(dateVector) - datenum(date));
    switch preOrPost
        case 'exact'
            index = find(dateVector == date);
            timedistToDate = 0;
            actualDate = date;
        case 'pre'
            diff(diff>0) = inf;
            assert(any(~isinf(diff))); % U805233: December 09, 2019 - 13:11:47
            [timedistToDate,~] = min(abs(diff));
            idcs = abs(diff) == timedistToDate;
            if allAtDate
                index = find(idcs);
            else
                index = find(idcs,1,'last');
            end
        case 'post'
            diff(diff<0) = inf;
            assert(any(~isinf(diff))); % U805233: December 09, 2019 - 13:12:00
            [timedistToDate,~] = min(diff);
            idcs = abs(diff) == timedistToDate;
            if allAtDate
                index = find(idcs);
            else
                index = find(idcs,1,'first');
            end
    end
    actualDate = dateVector(index);
end
