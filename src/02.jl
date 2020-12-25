# prints solution of both parts
function x()
	io = open("2.txt", "r")

	n = 0
	m = 0

	for i=1:1000
		a = parse(Int, readuntil(io, "-"))
		b = parse(Int, readuntil(io, " "))
		c = read(io, Char)
		read(io, Char)
		read(io, Char)
		d = readline(io)
		
		if a <= count(x->x==c, d) <= b
			m += 1
		end
		
		if d[a] == c && d[b] != c || d[a] != c && d[b] == c
			n += 1
		end
	end
	println(m)
	println(n)
end
