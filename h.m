function r = h(y, g, n)
    epi = 0.005;
    r = zeros(n,1);
    for i = 1:n
        r(i) = y(i) - g(i);
        if (r(i) < 0)
            r(i) = epi;
        end
    end
end