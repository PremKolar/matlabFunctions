function out = findInCellsWithKey(C,key,vertical)
   
    if nargin<3
        vertical = 0;
    end
    
    [~,~,linIdx] = gen.findIndexInCellsWithKey(C,key,vertical);
   
    out = C{linIdx};
    
end