using DelimitedFiles
function x(mv)
	mp = readdlm("3.txt")
	pos = [1,1]
	n = 0
	while pos[2] <= length(mp)
		if mp[pos[2]][pos[1]] == '#'
			n += 1
		end
		pos += mv
		pos[1] = (pos[1]-1) % length(mp[1]) + 1
	end
	return n
end
# part 1
println(x([3,1]))
# part 2
println(x([1,1])*x([3,1])*x([5,1])*x([7,1])*x([1,2]))
