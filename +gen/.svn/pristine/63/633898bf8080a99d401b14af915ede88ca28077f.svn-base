% Current date   = March 09, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
classdef qatetimeANDqurationTEST < matlab.unittest.TestCase
    
    properties
        d1 gen.qatetime
        d2 gen.qatetime
        q1 gen.quration
        q2 gen.quration
        q3 gen.quration
    end
    
    methods
        function obj = qatetimeANDqurationTEST()
            obj.d1 = gen.qatetime(now);
            obj.d2 = gen.qatetime(now-100);
            obj.q1 = gen.quration(1,1,1);
            obj.q2 = gen.quration(now);
            obj.q3 = gen.quration(inf);
        end
    end
    
    methods (Test)
        function testA(obj)
            res = obj.d1 + obj.q1;
            obj.verifyGreaterThan(res.num,now);
            obj.verifyClass(res,'gen.qatetime');
        end
        
        function testB(obj)
            res = obj.d2 + obj.q1;
            obj.verifyLessThan(res.num,now);
            obj.verifyClass(res,'gen.qatetime');
        end
        
        function testC(obj)
            res = obj.d1 - obj.d2;
            obj.verifyLessThan(res.days,101);
            obj.verifyClass(res,'gen.quration');
        end
        
        function testD(obj)
            res = obj.q1 - obj.q2;
            obj.verifyClass(res,'gen.quration');
            obj.verifyLessThan(res.days,0);
        end
        
        
        
        
        
    end
    
end