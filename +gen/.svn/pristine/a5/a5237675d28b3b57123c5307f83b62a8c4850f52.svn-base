% NK
function [totalCosts,costsPerYear] = escalateCostsOverYears(baseCost,units,escRate,basedate,dateA,dateB)
    validateattributes(baseCost,{'double'},{'scalar'})
    validateattributes(units,{'double'},{'scalar'})
    validateattributes(escRate,{'double'},{'scalar','>=',0,'<=',100})
    validateattributes(basedate,{'double'},{'scalar'})
    validateattributes(dateA,{'double'},{'scalar'})
    validateattributes(dateB,{'double'},{'scalar'})
    assert(ceil(dateB) >= floor(dateA))
    
    years = gen.year(dateA):gen.year(dateB);
    
    contributionsPerYear = gen.daysInYear(years);
    contributionsPerYear(1) = gen.daysLeftInYear(dateA);
    contributionsPerYear(end) = gen.dayofyear(dateB);
    contributionsPerYear = contributionsPerYear/sum(contributionsPerYear); % normalize
    
    unitsPerYear = contributionsPerYear * units;
    costsPerUnit = baseCost * (1+escRate/100).^(years - gen.year(basedate)); % yearly values
    costsPerYear = costsPerUnit.*unitsPerYear;
    totalCosts = sum(costsPerYear);
    
end