# returns solution of part 1
function x()
	f = open("13.txt")
	n = parse(Int, readline(f))
	l = readline(f)
	min = 0
	found = false
	minline = 0
	for line in split(l, ",")
		m = 0
		try
			m = parse(Int, line)
		catch
			continue
		end
		q = n ÷ m + 1
		if !found
			min = q*m
			minline = m
			found = true
		elseif q*m < min
			min = q*m
			minline = m
		end
	end
	(min - n) * minline
end

# prints solution of part 2
function y()
	f = open("13.txt")
	n = parse(Int, readline(f))
	l = readline(f)
	t = split(l, ",")
	time = 1
	maxok = 0
	incr = 1
	while true
		ok = true
		for i = 1:length(t)
			if t[i] == "x"
				continue
			end
			id = parse(Int, t[i])
			if (time+i) % id != 0
				ok = false
				break
			elseif i > maxok
				incr *= id
				println(time+1, " ", id, " OK")
				maxok = i
			end
		end
		if ok
			println(time+1)
			break
		end
		time += incr
	end
end
