# returns solution of part 1
function x()
	f = open("14.txt")
	andmask = 2^36-1
	ormask = 0
	arr = Dict{Int64, Int64}()
	for i = 1:549
		l = readline(f)
		if l[1:6] == "mask ="
			msk = l[8:end]
			andmask = parse(Int, replace(msk, "X" => "1"), base=2)
			ormask = parse(Int, replace(msk, "X" => "0"), base=2)
		elseif l[1:3] == "mem"
			i = findfirst("=", l).start
			ind = parse(Int, l[5:i-3])
			val = parse(Int, l[i+2:end])
			val &= andmask
			val |= ormask
			arr[ind] = val
		end
	end
	s = 0
	for (k,v) in arr
		s += v
	end
	s
end

# returns solution of part 2
function y()
	f = open("14.txt")
	ormasks = []
	andmask = 2^36-1
	arr = Dict{Int64, Int64}()
	for i = 1:549
		l = readline(f)
		if l[1:6] == "mask ="
			msk = l[8:end]
			xs = count(c->c=='X',msk)
			ormasks = []
			for i=0:(1<<xs-1)
				mask = collect(msk)
				andmask2 = collect(repeat('1', 36))
				j = 0
				for k = length(mask):-1:1
					if mask[k] == 'X'
						if i & (1 << j) > 0
							mask[k] = '1'
						else
							mask[k] = '0'
						end
						andmask2[k] = '0'
						j += 1
					end
				end
				push!(ormasks, parse(Int, String(mask), base=2))
				andmask = parse(Int, String(andmask2), base=2)
			end
		elseif l[1:3] == "mem"
			i = findfirst("=", l).start
			ind = parse(Int, l[5:i-3])
			val = parse(Int, l[i+2:end])
			for mask in ormasks
				ind2 = ind & andmask
				ind3 = ind2 | mask
				arr[ind3] = val
			end
		end
	end
	s = 0
	for (k,v) in arr
		s += v
	end
	s
end
