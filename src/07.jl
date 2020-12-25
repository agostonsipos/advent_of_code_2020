using DataStructures

function ancestors(str1, str2) :: Vector{Pair{String, String}}
	f = open("7.txt")
	res = []
	for i=1:594
		l = readline(f)
		words = split(l, " ")
		for j=3:length(words)-1
			if words[j] == str1 && words[j+1] == str2
				push!(res, Pair(words[1], words[2]))
				#println(words[1], words[2])
				break
			end
		end
	end
	res
end

#returns solution of part 1
function x()
	q = Queue{Pair{String,String}}()
	s = Set{Pair{String, String}}()
	v = ancestors("shiny", "gold")
	for e in v
		enqueue!(q,e)
	end
	n = 0
	while !isempty(q)
		#println(q)
		y = dequeue!(q)
		if(in(y, s))
			continue
		end
		push!(s, y)
		n += 1
		v = ancestors(y...)
		for e in v
			enqueue!(q,e)
		end
	end
	n
end


function descendants(str1, str2) :: Vector{Pair{Pair{String, String}, Int32}}
	f = open("7.txt")
	res = []
	for i=1:594
		l = readline(f)
		words = split(l, " ")
		if words[1] == str1 && words[2] == str2
			for j = 3:length(words)-2
				n = 0
				try
					n = parse(Int, words[j])
				catch
					continue
				end
				push!(res, Pair(Pair(words[j+1], words[j+2]), n))
			end
			break
		end
	end
	res
end

#returns solution for part 2
function y()
	q = Queue{Pair{Pair{String, String}, Int32}}()
	v = descendants("shiny", "gold")
	for e in v
		enqueue!(q,e)
	end
	n = 0
	while !isempty(q)
		#println(q)
		y = dequeue!(q)
		n += y.second
		v = descendants(y.first...)
		for e in v
			enqueue!(q, Pair(e.first, e.second * y.second))
		end
	end
	n
end
