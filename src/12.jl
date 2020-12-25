using DelimitedFiles

function move(pos, cmd, dir)
	w = cmd[1]
	n = parse(Int, cmd[2:end])
	if w == 'N'
		pos += [n,0]
	elseif w == 'S'
		pos -= [n,0]
	elseif w == 'E'
		pos += [0,n]
	elseif w == 'W'
		pos -= [0,n]
	elseif w == 'L'
		dir = [cosd(n) sind(n);-sind(n) cosd(n)]*dir
	elseif w == 'R'
		dir = [cosd(n) -sind(n);sind(n) cosd(n)]*dir
	elseif w == 'F'
		pos += n*dir
	end
	pos = round.(pos)
	dir = round.(dir)
	(Int.(pos),Int.(dir))
end

# returns solution of part 1
function x()
	t = readdlm("12.txt", String)
	pos = [0,0]
	dir = [0,1]
	for c in t
		(pos, dir) = move(pos, c, dir)
	end
	abs(pos[1])+abs(pos[2])
end

function move2(spos, wpos, cmd)
	w = cmd[1]
	n = parse(Int, cmd[2:end])
	if w == 'N'
		wpos += [n,0]
	elseif w == 'S'
		wpos -= [n,0]
	elseif w == 'E'
		wpos += [0,n]
	elseif w == 'W'
		wpos -= [0,n]
	elseif w == 'L'
		diff = wpos - spos
		diff = [cosd(n) sind(n);-sind(n) cosd(n)]*diff
		wpos = spos + diff
	elseif w == 'R'
		diff = wpos - spos
		diff = [cosd(n) -sind(n);sind(n) cosd(n)]*diff
		wpos = spos + diff
	elseif w == 'F'
		mv = wpos - spos
		spos += n*mv
		wpos += n*mv
	end
	spos = round.(spos)
	wpos = round.(wpos)
	(Int.(spos),Int.(wpos))
end

# returns solution of part 2
function y()
	t = readdlm("12.txt", String)
	spos = [0,0]
	wpos = [1,10]
	for c in t
		(spos, wpos) = move2(spos, wpos, c)
	end
	abs(spos[1])+abs(spos[2])
end
