% NK
function [out_perc,out_value] = sumPercentages(A_value,A_perc,B_value,B_perc)
    narginchk(4,4)
    
    validateattributes(A_value,{'double'},{})
    validateattributes(B_value,{'double'},{'size',size(A_value)})
    validateattributes(A_perc,{'double'},{'size',size(A_value),'>=',0,'<=',100})
    validateattributes(B_perc,{'double'},{'size',size(A_value),'>=',0,'<=',100})
   
    % calc
    out_value = A_perc/100 .* A_value +  B_perc/100 .* B_value;
    out_perc  = out_value./(A_value + B_value)*100;
    
end