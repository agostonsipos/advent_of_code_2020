# prints solution of both parts
function x()
	f = open("4.txt")
	c1 = 0
	c2 = 0
	s1 = 0
	s2 = 0
	for i=1:954
		l = readline(f)
		if l == ""
			if s1 >= 7
				c1 += 1
			end
			if s2 >= 7
				c2 += 1
			end
			s1 = 0
			s2 = 0
			continue
		end
		for kv in split(l, " ")
			k = split(kv, ":")[1]
			v = split(kv, ":")[2]
			if k == "byr"
				s1 += 1
				y = parse(Int, v)
				if 1920 <= y <= 2002
					s2 += 1
				end
			elseif k == "iyr"
				s1 += 1
				y = parse(Int, v)
				if 2010 <= y <= 2020
					s2 += 1
				end
			elseif k == "eyr"
				s1 += 1
				y = parse(Int, v)
				if 2020 <= y <= 2030
					s2 += 1
				end
			elseif k == "hgt"
				s1 += 1
				a = findfirst(isequal('c'), v)
				b = findfirst(isequal('i'), v)
				if typeof(a) != Nothing
					cm = parse(Int, v[1:a-1])
					if 150 <= cm <= 193
						s2 += 1
					end
				elseif typeof(b) != Nothing
					inch = parse(Int, v[1:b-1])
					if 59 <= inch <= 76
						s2 += 1
					end
				end
			elseif k == "hcl"
				s1 += 1
				if v[1] == '#' && length(v) == 7
					try
						h = parse(Int, v[2:7], base=16)
						s2 += 1
					catch
						s2 += 0
					end
				end
			elseif k == "ecl"
				s1 += 1
				if v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
					s2 += 1
				end
			elseif k == "pid"
				s1 += 1
				if length(v) == 9
					try
						h = parse(Int, v)
						s2 += 1
					catch
						s2 += 0
					end
				end
			end
		end
	end
	println(c1)
	println(c2)
end
