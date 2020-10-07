% NK
% use like gen.datenumVarInput({'4.Mar.19','04 03 2019','04/Mär/2019','04\Mär\2019'},'GER')
% or  like gen.datenumVarInput({'Mar.4.19','03.04.2019','Mär.04.2019','Mär\04\2019'},'US')
function out = datenumVarInput(in,country)
    % country check
    assert(ischar(country));
    country = lower(country);
    assert(ismember(country,{'ger','us'}));
    % in check
    if ischar(in)
        in = {in};
    end
    assert(iscell(in));
    cellfun(@(x)assert(ischar(x)&&length(x)>=6),in);
    
    %
    seperators = '[\s\.\\\/\_-]';
    
    %
    out = nan(size(in));
    for j = 1:numel(in)
        % split up
        C = in{j};
        
        [C,s.time] = checkForTimeStrAppendix(C);
        C = checkForYearFirstFormat(C,seperators);
        
        splitidcs = regexp(C,seperators);
        switch country
            case 'ger'
                s.day = C(1:splitidcs(1)-1);
                s.month = C(splitidcs(1)+1:splitidcs(2)-1);
            case 'us'
                s.month = C(1:splitidcs(1)-1);
                s.day = C(splitidcs(1)+1:splitidcs(2)-1);
        end
        s.year = C(splitidcs(2)+1:end);
        % get components
        day   = checkDayFormat(s.day);
        month = checkMonthFormat(s.month);
        year  = checkYearFormat(s.year);
        time = checkTimeFormat(s.time);
        day  = day+time;
        
        % write
        out(j) = datenum(year,month,day);
        
        % test
        assert(floor(out(j))==datenum(datestr(out(j),'yyyymmdd'),'yyyymmdd'));
    end    
end

function [out, timeStr] = checkForTimeStrAppendix(in)
    [a,b] = regexp(in,'\s\d{2}:\d{2}(:\d{2})?');
    timeStr = strip(in(a:b));
    if ~isempty(timeStr)
        out = in(1:a-1);
    else
        out = in;
        timeStr = '00:00:00';
    end
end

function in = checkForYearFirstFormat(in,seperators)
    if ~isempty(regexp(in,['\d{4}' seperators '\d{2}' seperators '\d{2}'], 'once'))
        [a,b] = regexp(in,seperators);
        in =  [in(b(1)+1:end)  in(a(1):b(1)) in(1:a(1)-1)];
    end
end

function [day,frmt] = checkDayFormat(s)
    if ~isempty(regexp(s,'^\d{1,2}$', 'once'))
        frmt = 'dd';
        day = str2double(s);
    else
        error('?')
    end
    assert(day>0&&day<32);
end

function [month, frmt] = checkMonthFormat(s)
    if ~isempty(regexp(s,'^\d{1,2}$', 'once'))
        frmt = 'mm';
        month = str2double(s);
    elseif regexp(s,'^[A-Za-zä]{3,}(\.)?$')
        s = regexprep(s,'\.','');
        s(1) = upper(s(1));
        s(2:end) = lower(s(2:end));
        idx = cellfun(@(x)~isempty(regexp(x,['^' s '.*'], 'once')),usMonths); % look in US months
        if ~any(idx)
            idx = cellfun(@(x)~isempty(regexp(x,['^' s '.*'], 'once')),germanMonths); % look in german months
        end
        if ~any(idx)
            error('huh?')
        end
        month = find(idx);
    end
    assert(~isempty(month)&&month>0&&month<13);
end

function [year,frmt] = checkYearFormat(s)
    assert(regexp(s,'^\d{2,4}$')&&(length(s)==2||length(s)==4));
    if length(s)==2
        year = str2double(datestr(datenum(s,'yy'),'yyyy'));
        frmt = 'yy';
    else
        year =  str2double(s);
        frmt = 'yyyy';
    end
    assert(year>0);
end

function dayfrac = checkTimeFormat(s)
    s = strip(s);
    n=@str2double;
    dayfrac = n(s(1:2))/24 + n(s(4:5))/60/24;
    if ~isempty(regexp(s,'^\d{2}:\d{2}:\d{2}$', 'once'))
        dayfrac =  dayfrac + n(s(7:8))/60/60/24; % seconds
    end
end

function gms = usMonths
    gms =     {
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
        'August'
        'September'
        'October'
        'November'
        'December'
        };
end

function gms = germanMonths
    gms =     {
        'Januar'
        'Februar'
        'März'
        'April'
        'Mai'
        'Juni'
        'Juli'
        'August'
        'September'
        'Oktober'
        'November'
        'Dezember'
        };
end


