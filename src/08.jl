using DelimitedFiles

# returns solution of part 1 (without parameters)
function process(swap = 0)
	lines = readdlm("8.txt")
	i = 1
	s = Set()
	acc = 0
	while true
		push!(s, i)
		c = ""
		n = 0
		try
			c = lines[i,1]
			n = lines[i,2]
		catch
			break
		end
		#println(i, ": ", c, " ", n)
		if i == swap && c == "jmp"
			c = "nop"
		elseif i == swap && c == "nop"
			c = "jmp"
		end
		
		if c == "acc"
			acc += n
			i += 1
		elseif c == "jmp"
			i += n
		else
			i += 1
		end
		if in(i, s)
			if swap > 0
				return Nothing
			else
				break
			end
		end
	end
	acc
end

# prints solution of part 2
function findChange()
	lines = readdlm("8.txt")
	for swap = 1:size(lines,1)
		x = process(swap)
		if x != Nothing
			println(x)
		end
	end
end
