% NK
% fills missing columns with dummy value (at the end of/at missing columnnames of) the slimmer matrix
function out = vertcat2matricesOfDifferentWidth(A,B,dummyvalue,hasColumnNames)
    narginchk(4,4)
    if size(A,1)==0
        out = B;
        return
    end
    if size(B,1)==0
        out = A;
        return
    end
    
    assert(strcmp(class(A),class(B)))   % can be cell or double or whatever
    assert(numel(dummyvalue)==1) % eg nan or '' or {'blib'}
    assert(strcmp(class(dummyvalue),class(B)))
    
    [ya,xa] = size(A);
    [yb,xb] = size(B);
    diff = xa-xb;
    if ~hasColumnNames %TODONN: es werden die Columns nicht an die richtige Stelle geschrieben : BSp GWI DLH Merge
        if diff<0
            A = [A repmat(dummyvalue,ya,abs(diff))];
        elseif diff>0
            B = [B repmat(dummyvalue,yb,abs(diff))];
        end
    else
        colNamesA = gen.simplifyHeader(A(1,:));
        colNamesB = gen.simplifyHeader(B(1,:));
        colNamesAreal = A(1,:);
        colNamesBreal  = B(1,:); 
        C = setdiff(colNamesB,colNamesA);
        idx_colB = ismember(colNamesB,C);
        C = colNamesBreal(idx_colB);
        
        if numel(C)>0
            A = [A [C;repmat(dummyvalue,ya-1,numel(C))]];
        end
        C = setdiff(colNamesA,colNamesB);
        idx_colA = ismember(colNamesA,C);
        C = colNamesAreal(idx_colA);
        if numel(C)>0
            B = [B [C;repmat(dummyvalue,yb-1,numel(C))]];
        end
        [is,where] = ismember(gen.simplifyHeader(B(1,:)),gen.simplifyHeader(A(1,:)));
        assert(all(is));
        assert(gen.isDistinct(where));
        B = B(2:end,where);
    end
    out = [A;B];
end
