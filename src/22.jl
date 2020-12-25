using DataStructures

function readPlayer(f, N)
	p = Queue{Int}()
	for i=1:N
		k = parse(Int, readline(f))
		enqueue!(p, k)
	end
	p
end

function parsegame(N)
	f = open("22.txt")
	readline(f)
	p1 = readPlayer(f, N)
	readline(f)
	readline(f)
	p2 = readPlayer(f, N)
	(p1, p2)
end

# returns solution of part 1
function x()
	N = 25
	(p1, p2) = parsegame(N)
	
	while length(p1) > 0 && length(p2) > 0
		a = dequeue!(p1)
		b = dequeue!(p2)
		if a < b
			enqueue!(p2, b)
			enqueue!(p2, a)
		else
			enqueue!(p1, a)
			enqueue!(p1, b)
		end
	end
	x = 0
	for i=(2*N):-1:1
		x += dequeue!(p1) * i
	end
	x
end


function game(p1, p2)
	hist = Set{Tuple{Vector{Int}, Vector{Int}}}()
	while length(p1) > 0 && length(p2) > 0
		#println(p1)
		#println(p2)
		if (collect(p1), collect(p2)) in hist
			#println("repeat of ", p1, p2)
			return (true, p1, p2)
		end
		push!(hist, (collect(p1), collect(p2)))
		a = dequeue!(p1)
		b = dequeue!(p2)
		if a > length(p1) || b > length(p2)
			if a < b
				enqueue!(p2, b)
				enqueue!(p2, a)
			else
				enqueue!(p1, a)
				enqueue!(p1, b)
			end
		else
			q1 = copy(collect(p1))
			q2 = copy(collect(p2))
			r1 = Queue{Int}()
			r2 = Queue{Int}()
			for i=1:a
				enqueue!(r1, q1[i])
			end
			for i=1:b
				enqueue!(r2, q2[i])
			end
			p1won = game(r1, r2)[1]
			if p1won
				enqueue!(p1, a)
				enqueue!(p1, b)
			else
				enqueue!(p2, b)
				enqueue!(p2, a)
			end
		end
	end
	(length(p2) == 0, p1, p2)
end

# returns solution of part 2 (slow solution: 5.997827 seconds)
function y()
	N = 25
	(p1, p2) = parsegame(N)
	who, q1, q2 = game(p1, p2)
	x = 0
	if who
		for i=(2*N):-1:1
			x += dequeue!(q1) * i
		end
	else
		for i=(2*N):-1:1
			x += dequeue!(q2) * i
		end
	end
	x
end
