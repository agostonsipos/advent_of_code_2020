function x()
	a = 12320657
	b = 9659666
    m = 20201227
    e = 1
    l = 0
    while e != a
        e *= 7
        e %= m
        l += 1
    end
    k = 1
    for i=1:l
        k *= b
        k %= m
    end
    println(k)
end
