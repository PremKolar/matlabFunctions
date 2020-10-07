function [days,ratio] = daysOfTspanInOneMonth(from,till,month)
        m1 = gen.firstDayInMonth(month);
        m2 = gen.lastDayInMonth(month);
        
        b = min([m2,till]);
        a = max([m1,from]);
        
        days = max([0 b-a+1]);        
        ratio = days/(m2-m1+1);
        
end