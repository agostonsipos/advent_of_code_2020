function isvalid(n, rules)
	ok = false
	for cat in rules
		for r in cat
			if n >= r[1] && n <= r[2]
				ok = true
			end
		end
	end
	return ok
end

function isvalid_i(n, rule)
	ok = false
	for r in rule
		if n >= r[1] && n <= r[2]
			ok = true
		end
	end
	return ok
end
	

function buildrules(f)
	rules = []
	for i=1:20
		l=readline(f)
		push!(rules, [])
		for w in split(l, " ")
			if length(split(w, "-")) == 2
				rule1 = split(w, "-")[1]
				rule2 = split(w, "-")[2]
				rule = [parse(Int64, rule1), parse(Int64, rule2)]
				push!(rules[i], rule)
			end
		end
	end
	(f, rules)
end

# returns solution of part 1
function x()
	f = open("16.txt")
	(f, rules) = buildrules(f)
	
	for i=1:5
		readline(f)
	end
	
	s = 0
	for i=1:244
		l=readline(f)
		ok = true
		for n in split(l, ",")
			if !isvalid(parse(Int64, n), rules)
				s += parse(Int64, n)
			end
		end
	end
	s
end

# returns solution of part 2
function y()
	f = open("16.txt")
	(f, rules) = buildrules(f)
	readline(f)
	readline(f)
	ticket = [parse(Int64,t) for t in split(readline(f), ",")]
	readline(f)
	readline(f)
	
	tab = Array{Int64,2}(undef, 244, 20)
	k = 1
	for i=1:244
		l=readline(f)
		t = split(l, ",")
		for j=1:20
			if !isvalid(parse(Int64,t[j]), rules)
				@goto here
			end
			tab[k,j] = parse(Int64,t[j])
		end
		k += 1
		@label here
	end
	k -= 1
	table = Array{Int64,2}(undef, k, 20)
	for i=1:k, j=1:20
		table[i,j] = tab[i,j]
	end
	
	a = []
	for i=1:20
		s = Set(collect(1:20))
		for j=1:k
			s2 = Set()
			for r = 1:20
				if isvalid_i(table[j,i], rules[r])
					push!(s2, r)
				end
			end
			intersect!(s, s2)
		end
		push!(a, s)
	end
	
	removed = Set{Int64}()
	for q=1:19
		el = 0
		for i=1:20
			if length(a[i]) == 1 && !in(first(a[i]), removed)
				el = first(a[i])
				push!(removed, el)
				break
			end
		end
		for b in a
			if length(b) > 1
				delete!(b, el)
			end
		end
	end
	res = 1
	for i=1:20
		if any(in.([1,2,3,4,5,6], repeat([a[i]],6)))
			res *= ticket[i]
		end
	end
	res
end
