% if T.Properties.Description has string like:
% Column Names:    bla    blubb   blibb ... (tab delimited)
% those will be used as column names. otehrwise variable names will be used
function table2MTable(MT,T,color,hideDummies,decimalPlaces,colorLastLine,hideEmptyRows,keepNumerics)
    
    if nargin>6 && hideEmptyRows
        emptyrows = gen.nansum(table2array(T),2)==0;
        T(emptyrows,:) = [];
    end
    
    Tc = table2cell(T);
    
    if nargin<3 || isempty(color)
        color = [.5 1 1];
    end
    if nargin<5
        decimalPlaces = 0;
    end
    
    if nargin<8 || ~keepNumerics
    for j=1:numel(Tc)
        if isnumeric(Tc{j})
            Tc{j} = eval(['sprintf(''%.' num2str(decimalPlaces) 'f'',Tc{j})']); % so slow 
        end
    end
    end
    % check for logical data
    
    if all(cellfun(@islogical,Tc))
        Tc = logical2X(Tc);
    end
    
    if nargin>3 && hideDummies
        Tc = dummy2empty(Tc);
    end
    
    if nargin<6
        colorLastLine = false;
    end
    
    
    if isempty(T.Row)
        if isempty(T)
            T.Row = cell(0,1);
        else
            T.Row = cellfun(@(x){num2str(x)},num2cell(1:size(T,1)));
        end
    end
    
    %% build
    cn = strfind(T.Properties.Description,'Column Names');
    if cn
        colNames = [{''} strsplit(T.Properties.Description(cn+length('Column Names: '):end),'\t')];
    else
        colNames = [{''} T.Properties.VariableNames];
    end
     % Data
     Data = [T.Row Tc];
     if ~isempty(MT.ColumnName)
         % check whether column names are set already and in which order
         [is,where] = ismember(gen.empty2emptyStr(MT.ColumnName),colNames);
         % resort to already set order
         if numel(colNames)==MT.X && all(is) && ~isempty(MT.ColumnName)
             Data = Data(:,where);
             colNames = colNames(where);
         end
     end
    % refresh
    MT.Data = Data;
    MT.ColumnName = colNames;
    % color rows
    if isempty(MT.ColumnName{1})
        gen.MTableColorRowNames(MT,color,colorLastLine);
    end
end

function in = dummy2empty(in)
    for k=1:numel(in)
        try %#ok<TRYNC>
            in(k) = erase(in(k),{'NaN' 'nan' 'Nan' 'naN'});
        end
    end
    in(cell2mat(cellfun(@(x) str2double(x)==0,in,'UniformOutput',false))) = {''};
end


function in = logical2X(in)
    
    for k=1:numel(in)
        if in{k}
            in{k} = 'x';
        else
            in{k} = '';
        end
    end
end

