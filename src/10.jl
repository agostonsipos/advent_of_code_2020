using DelimitedFiles

# returns solution of part 1
function x()
	t = vec(readdlm("10.txt", Int64))
	sort!(t)
	
	a=b=0
	prev = 0
	for ch in t
		if ch - prev == 1
			a += 1
		elseif ch - prev == 3
			b += 1
		end
		prev = ch
	end
	b += 1
	a*b
end

# returns solution of part 2
function y()
	t = sort(vec(readdlm("10.txt", Int64)))
	
	nums = Array{Int64,1}(zeros(maximum(t)+3))
	
	for ch in t
		s = ch <= 3 ? 1 : 0
		for i = max(1, ch-3):ch-1
			s += nums[i]
		end
		nums[ch] = s
	end
	nums[maximum(t)]
end
