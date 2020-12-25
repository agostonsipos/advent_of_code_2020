function operation(s, n, op)
	if s == undef
		s = n
	else
		if op == '+'
			s += n
		elseif op == '*'
			s *= n
		end
	end
	s
end

function eval1(expr, start = 1)
	ops = split(expr, " ")
	s = undef
	lastop = undef
	i = start
	while i <= length(ops)
		try
			n = parse(Int, ops[i])
			s = operation(s, n, lastop)
		catch
			op = ops[i]
			if op[1] in ['+','*']
				lastop = op[1]
			elseif op[1] == '('
				(x,i) = eval1(expr, i+1)
				s = operation(s, x, lastop)
			elseif op[1] == ')'
				return (s, i)
			end
		end
		i += 1
	end
	(s, length(ops))
end

function replaceplusmul(e)
	for i=1:length(e.args)
		if e.args[i] == :+
			e.args[i] = :*
		elseif e.args[i] == :*
			e.args[i] = :+
		elseif typeof(e.args[i]) == Expr
			e.args[i] = replaceplusmul(e.args[i])
		end
	end
	e
end

function eval2(expr)
	expr = replace(expr, "+" => "#")
	expr = replace(expr, "*" => "+")
	expr = replace(expr, "#" => "*")
	e = Meta.parse(expr)
	e = replaceplusmul(e)
	x = eval(e)
end

#prints solution of both parts
function x()
	f = open("18.txt")
	s1 = 0
	s2 = 0
	for i=1:377
		#println("line {$i}")
		e = readline(f)
		s1 += eval1(e)[1]
		s2 += eval2(e)[1]
	end
	println(s1)
	println(s2)
end
