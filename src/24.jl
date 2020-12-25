using DataStructures
function move(cmds)
    x = y = z = 0
    for cmd in cmds
        if cmd == "e"
            x += 1
            y -= 1
        elseif cmd == "se"
            z += 1
            y -= 1
        elseif cmd == "sw"
            x -= 1
            z += 1
        elseif cmd == "w"
            x -= 1
            y += 1
        elseif cmd == "nw"
            y += 1
            z -= 1
        elseif cmd == "ne"
            x += 1
            z -= 1
        end
    end
    return (x,y,z)
end

function parseline(str)
    cmd :: Array{String, 1} = []
    i = 1
    while i <= length(str)
        if str[i] == 'n' || str[i] == 's'
            push!(cmd, str[i:i+1])
            i += 2
        else
            push!(cmd, str[i:i])
            i += 1
        end
    end
    cmd
end

function neighbours(x, y, z)
    return [(x+1,y-1,z), (x,y-1,z+1), (x-1,y,z+1), (x-1,y+1,z), (x,y+1,z-1), (x+1,y,z-1)]
end

# prints solution of both parts
function x()
    f = open("24.txt")
    s = Set{Tuple{Int,Int,Int}}()
    for i=1:344
        coord = move(parseline(readline(f)))
        if coord in s
            delete!(s, coord)
        else
            push!(s, coord)
        end
    end
    println(length(s))
    for i=1:100
        t = copy(s)
        for x = -100:100, y = -100:100
            z = -x-y
            N = neighbours(x, y, z)
            isblack = (x,y,z) in s
            c = 0
            for n in N
                if n in s
                    c += 1
                end
            end
            if isblack && (c == 0 || c > 2)
                delete!(t, (x,y,z))
            elseif !isblack && c == 2
                push!(t, (x,y,z))
            end
        end
        s = t
    end
    println(length(s))
end
