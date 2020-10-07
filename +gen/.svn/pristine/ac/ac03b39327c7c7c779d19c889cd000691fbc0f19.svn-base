% this should go into MTable directly
function MTableColorRowNames(M,col,alsoLastLine,every2nd)
    if nargin<4
        every2nd=false;
    end
     if every2nd
        rownameidcs = 1:2:size(M.Data,2);
    else
        rownameidcs = 1;
    end
    truecolor = @(x)M.truecolor(x);
    clr      = M.CellColor;
    clr(:,rownameidcs) = truecolor(col);
    if nargin>2 && alsoLastLine
        clr(end,:) = truecolor(col);
    end
    M.CellColor = clr;
   
    
    M.CellEditable(:,rownameidcs)= false;
    
end