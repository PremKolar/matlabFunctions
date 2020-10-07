function deleteSheetXInXlsx(file,x)
    newExcel = actxserver('excel.application');
    excelWB = newExcel.Workbooks.Open(file,0,false);
    newExcel.DisplayAlerts = false;
    excelWB.Sheets.Item(x).Delete;
    excelWB.Save();
    excelWB.Close();
    newExcel.Quit();
    delete(newExcel);
end