function signal = blackmanWindow(f, fx, f1, f2)

    w = zeros(size(f));
    bm = blackman(max(size(find(f1 <= f & f <= f2))));
    id = find(f1 <= f, 1, 'first');
    w(id:id+length(bm)-1) = bm;
    id = find(-f2 <= f, 1, 'first');
    w(id:id+length(bm)-1) = bm;
    
    signal = w'.*fx;

end