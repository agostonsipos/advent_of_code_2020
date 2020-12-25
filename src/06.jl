#returns solution for both parts
function x()
	f = open("6.txt")
	c1 = 0
	c2 = 0
	s1 = Set()
	s2 = Set()
	b = true
	for i=1:2149
		l = readline(f)
		if l == ""
			c1 += length(s1)
			c2 += length(s2)
			s1 = Set()
			s2 = Set()
			b = true
			continue
		end
		g = Set()
		for char in l
			push!(g, char)
		end
		union!(s1, g)
		if !b
			intersect!(s2, g)
		else
			s2 = g
			b = false
		end
	end
	(c1, c2)
end
