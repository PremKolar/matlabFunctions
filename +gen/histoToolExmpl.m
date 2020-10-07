function histoToolExmpl()
    % date format must be that of the time variables
    datefrmt = 'mm.yyyy' %#ok<*NOPRT>
    
    %% set A
    % create table with bin (e.g. time) data. must be strings in case of "tool.binStyle = 'yearly'"
    time1 = {'01.2018' '06.2018' '01.2017' '01.2019' '01.2017' '07.2018' }'
    time2 = {'03.2018' '09.2018' '12.2016' '02.2019' '06.2017' '01.2019' }'
    TA = table(time1,time2)
    
    % create table with block data (that which is histogram'ed). can be
    % numerical or strings or char
    values1 = {'A' 'B' 'X' 'X' 'A' 'A' }'
    values2 = {1 3 1 3 2 5 }'
    values3 = {'bla' 'bla' 'blub' 'blub' 'blub' 'blub' }'
    VA = table(values1,values2,values3)
    
    
    %% set B
    time1 = {'01.2018' '06.2018' '01.2017' '01.2018'}' % must have same variable name and variable count as all other sets. length of one variable can differ
    time2 = {'03.2019' '09.2017' '12.2016' '02.2019'}'
    TB =  table(time1,time2)
    
    values1 = {'A' 'B' 'A' 'A' }'
    values2 = {3 2 5 5}' % must be same type as values2 of set A
    values3 = {'blib' 'blonk' 'blank' 'donk' }'
    VB = table(values1,values2,values3)
    
    %% create cell arrays of set tables
    % number of sets will be number of columns per bin
    T = [{TA} {TB}]
    D = [{VA} {VB}]
    
    tool = gen.histoTool(T,D) % create new obj
    tool.datefrmt = datefrmt; % set date format
    tool.binStyle = 'yearly'; % set bin style
    tool.setNames = {'A' 'B'} % set set names (optional)
    
    
end