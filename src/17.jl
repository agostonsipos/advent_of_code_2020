using DelimitedFiles

function readmat()
	t = vec(readdlm("17.txt", String))
	n = length(t)
	m = length(t[1])
	mat = Array{Char,2}(undef, n,m)
	for i=1:n, j=1:m
		mat[i,j] = t[i][j]
	end
	mat
end

function countNeighbours(vol, i,j,k)
	s = vol[i,j,k] == '#' ? -1 : 0
	for a=max(i-1,1):min(i+1,size(vol,1)), b=max(j-1,1):min(j+1,size(vol,2)), c=max(k-1,1):min(k+1,size(vol,3))
		s += vol[a,b,c] == '#' ? 1 : 0
	end
	s
end

function countNeighbours2(vol, i,j,k,l)
	s = vol[i,j,k,l] == '#' ? -1 : 0
	for a=max(i-1,1):min(i+1,size(vol,1)), b=max(j-1,1):min(j+1,size(vol,2)), c=max(k-1,1):min(k+1,size(vol,3)), d=max(l-1,1):min(l+1,size(vol,3))
		s += vol[a,b,c,d] == '#' ? 1 : 0
	end
	s
end

# prints solution of both parts
function x()
	mat = readmat()
	n = size(mat,1)
	m = size(mat,2)
	
	vol = Array{Char,3}(undef, n+12,m+12,13)
	fill!(vol, '.')
	for i=1:n, j=1:m
		vol[i+6,j+6,7] = mat[i,j]
	end
	vol
	for it=1:6
		vol2 = copy(vol)
		for i=1:n+12,j=1:m+12,k=(7-it):(7+it)
			N = countNeighbours(vol,i,j,k)
			if vol[i,j,k] == '.' && N == 3
				vol2[i,j,k] = '#'
			elseif vol[i,j,k] == '#' && !(2 <= N <= 3)
				vol2[i,j,k] = '.'
			end
		end
		vol = copy(vol2)
	end
	
	println(count(c->c=='#', vol))
	
	
	Vol = Array{Char,4}(undef, n+12,m+12,13,13)
	fill!(Vol, '.')
	for i=1:n, j=1:m
		Vol[i+6,j+6,7,7] = mat[i,j]
	end
	for it=1:6
		Vol2 = copy(Vol)
		for i=1:n+12,j=1:m+12,k=(7-it):(7+it),l=(7-it):(7+it)
			N = countNeighbours2(Vol,i,j,k,l)
			if Vol[i,j,k,l] == '.' && N == 3
				Vol2[i,j,k,l] = '#'
			elseif Vol[i,j,k,l] == '#' && !(2 <= N <= 3)
				Vol2[i,j,k,l] = '.'
			end
		end
		Vol = copy(Vol2)
	end
	
	println(count(c->c=='#', Vol))
	
end
