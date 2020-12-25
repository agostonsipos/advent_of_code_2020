using DelimitedFiles

function neighbours(mat, i, j)
	t = vec(mat[max(i-1,1):min(i+1,size(mat,1)), max(j-1,1):min(j+1,size(mat,2))])
	count(c->c=='#', t) - ((mat[i,j] == '#') ? 1 : 0)
end

function visible(mat, i, j)
	n = size(mat,1)
	m = size(mat,2)
	dirs = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
	c = 0
	for dir in dirs
		pos = [i,j]
		while true
			pos += dir
			if pos[1] < 1 || pos[2] < 1 || pos[1] > n || pos[2] > m
				break
			elseif mat[pos...] == '#'
				c += 1
				break
			elseif mat[pos...] == 'L'
				break
			end
		end
	end
	c
end

function x(func, num)
	t = vec(readdlm("11.txt", String))
	n = length(t)
	m = length(t[1])
	mat = Array{Char,2}(undef, n,m)
	for i=1:n, j=1:m
		mat[i,j] = t[i][j]
	end
	
	while true
		mat2 = copy(mat)
		for i=1:n, j=1:m
			if mat[i,j] == 'L' && func(mat, i, j) == 0
				mat2[i,j] = '#'
			elseif mat[i,j] == '#' && func(mat, i, j) >= num
				mat2[i,j] = 'L'
			end
		end
		if mat == mat2
			break
		end
		mat=copy(mat2)
		for i=1:n, j=1:m
			if mat2[i,j] == 'L' && func(mat2, i, j) == 0
				mat[i,j] = '#'
			elseif mat2[i,j] == '#' && func(mat2, i, j) >= num
				mat[i,j] = 'L'
			end
		end
		if mat == mat2
			break
		end
	end
	count(c->c=='#', mat)
end
#part 1
println(x(neighbours, 4))
#part 2
println(x(visible, 5))
