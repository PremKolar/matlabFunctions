function cells = anynums2strs(cells)
    if isnumeric(cells)
       cells = num2cell(cells); 
    end
    for j=1:numel(cells)
        if isnumeric(cells{j})
            cells{j} = num2str(cells{j});
        end
    end       
end