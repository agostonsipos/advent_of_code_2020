# prints solution of any part
function x(num = 30000000)
	f = open("15.txt")
	l = readline(f)
	d = Dict{Int, Int}()
	lastnum = 0
	i = 1
	for n in split(l, ",")
		x = parse(Int, n)
		lastnum = x
		#println(lastnum)
		d[lastnum] = i
		i+=1
	end
	c = 0
	while i <= num
		if lastnum in keys(d)
			c = i-1-d[lastnum]
		else
			c = 0
		end
		d[lastnum] = i-1
		lastnum = c
		i+=1
	end
	println(lastnum)
end
x(2020)
x(30000000)
