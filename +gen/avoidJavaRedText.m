% U805233: February 11, 2020 - 16:30:46
% http://undocumentedmatlab.com/articles/handling-red-java-console-errors
function avoidJavaRedText()
    pause(0.05); drawnow;  % this never hurt anyone!
    fprintf(' \b');
end