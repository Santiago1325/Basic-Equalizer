function signal = rectangularWindow(f, fx, f1, f2)

    w = zeros(size(f));
    w(f1 <= f & f <= f2) = 1;
    w(-f2 <= f & f <= -f1) = 1;
    
    signal = w'.*fx;
   
end