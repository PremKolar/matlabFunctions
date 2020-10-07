function sylvesterNum = year2newYearsDateNum(years)
    sylvesterNum = cellfun(@(y) datenum(y),arrayfun(@(x) [x 12 31 23 59 59],years,'UniformOutput',false));
