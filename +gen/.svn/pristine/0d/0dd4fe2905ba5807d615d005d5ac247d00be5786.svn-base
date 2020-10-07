function renameXlsxSheet(filename,newSheetName,oldSheet)
    e = actxserver('Excel.Application');
    ewb = e.Workbooks.Open(filename);
    
    if isnumeric(oldSheet)
        ewb.Worksheets.Item(oldSheet).Name = newSheetName;
    elseif ischar(oldSheet)
        TODO
    end
    ewb.Save
    ewb.Close(false)
    e.Quit
end