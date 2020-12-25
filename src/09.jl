using DataStructures
using DelimitedFiles

# returns solution of part 1
function x()
	q = []
	f = open("9.txt")
	for i=1:25
		n = parse(Int, readline(f))
		push!(q, n)
	end
	for i=1:1000-25
		n = parse(Int, readline(f))
		l = false
		for a=1:25
			for b=a:25
				if q[a] + q[b] == n
					l = true
				end
			end
		end
		if !l
			return n
		end
		for j=1:24
			q[j] = q[j+1]
		end
		q[25] = n
	end
end

# returns solution of part 2 (slow solution: 9.275257 seconds)
function y()
	t = readdlm("9.txt", Int64)
	n = x()
	p = (0,0)
	for i=1:length(t), j=i+2:length(t)
		s = 0
		for k=i:j
			s += t[k]
		end
		if s == n
			p = (i,j)
			break
		end
	end
	minimum(t[p[1]:p[2]]) + maximum(t[p[1]:p[2]])
end
