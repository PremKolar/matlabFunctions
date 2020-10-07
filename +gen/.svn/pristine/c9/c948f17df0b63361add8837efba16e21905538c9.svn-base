function assertDateFormat(dstr,frmt)
%     assert(strcmp(regexprep(dstr,'\d','x'),regexprep(frmt,'[dmyMSH]','x')));
    assert(strcmp( char(datetime(dstr,'Format',frmt)),dstr));
end