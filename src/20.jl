function readtile(f)
    M = 8
    title = readline(f)
    id = parse(Int, split(title, " ")[2][1:4])
    mat = Array{Char,2}(undef, M+2, M+2)
    for i = 1:M+2
        line = readline(f)
        mat[i,:] = collect(line)
    end
    readline(f)
    (id, mat)
end

function edges(mat)
    edgelist = Array{Array{Char,1},1}()
    push!(edgelist, mat[1,:])
    push!(edgelist, mat[end,:])
    push!(edgelist, mat[:,1])
    push!(edgelist, mat[:,end])
    edgelist
end

function rotate(mat)
    m = copy(mat)
    m = permutedims(m,(2,1))
    for i=1:size(m,1)
        m[i,:] = reverse(m[i,:])
    end
    m
end

function flip(mat)
    m = copy(mat)
    for i=1:size(m,1)
        m[i,:] = reverse(m[i,:])
    end
    m
end

# prints solution of both parts
function x()
	f = open("20.txt")
    N = 12
    M = 8
    list = []
    cnt = Dict{Int32, Int64}()
    tiles = Dict{Int32, Array{Char,2}}()
	for i=1:N*N
		(id, tile) = readtile(f)
        tiles[id] = tile
        cnt[id] = 0
        edgelist = edges(tile)
        for edge in edgelist
            push!(list, (id, edge))
        end
	end
    for i=1:length(list), j=1:length(list)
        if i != j && list[i][1] != list[j][1] && (list[i][2] == list[j][2] || reverse(list[i][2]) == list[j][2])
            cnt[list[i][1]] += 1
        end
    end
    y=1
    starttile = 0
    for (k, v) in cnt
        if v == 2
            y *= k
            starttile = k
        end
    end
    println(y)
    
    img = Array{Char,2}(undef, M*N, M*N)
    lastpadding = undef
    paddings = Array{Array{Char,1},1}(undef, N)
    fill!(img, 0)
    for i=1:N
        for j=1:N
            id = undef
            tile = undef
            if i==1 && j==1
                id = starttile
                tile = copy(tiles[id])
                while true
                    e = edges(tile)
                    a = count(f->f==e[2], map(a->a[2], list)) + count(f->reverse(f)==e[2], map(a->a[2], list))
                    b = count(f->f==e[4], map(a->a[2], list)) + count(f->reverse(f)==e[4], map(a->a[2], list))
                    if a > 1 && b > 1
                        break
                    end
                    tile = rotate(tile)
                    if tile == tiles[id]
                        tile = flip(tile)
                    end
                end
                tile=permutedims(tile,(2,1))
            elseif i == 1
                id = undef
                tile = undef
                for (iid,t) in tiles
                    f = false
                    while true
                        e = edges(t)
                        a = count(f->f==e[1], map(a->a[2], list)) + count(f->reverse(f)==e[1], map(a->a[2], list))
                        if a == 1 && e[3][1:2+M] == lastpadding
                            f = true
                            tile = copy(t)
                            break
                        end
                        t = rotate(t)
                        if t == tiles[iid]
                            t = flip(t)
                        elseif t == flip(tiles[iid])
                            break
                        end
                    end
                    if f
                        id = iid
                        break
                    end
                end
            elseif j == 1
                id = undef
                tile = undef
                for (iid,t) in tiles
                    f = false
                    while true
                        e = edges(t)
                        a = count(f->f==e[3], map(a->a[2], list)) + count(f->reverse(f)==e[3], map(a->a[2], list))
                        if a == 1 && e[1][1:2+M] == paddings[j]
                            f = true
                            tile = copy(t)
                            break
                        end
                        t = rotate(t)
                        if t == tiles[iid]
                            t = flip(t)
                        elseif t == flip(tiles[iid])
                            break
                        end
                    end
                    if f       
                        id = iid
                        break
                    end
                end
            else
                id = undef
                tile = undef
                for (iid,t) in tiles
                    f = false
                    while true
                        e = edges(t)
                        if e[1][1:2+M] == paddings[j] && e[3][1:2+M] == lastpadding
                            f = true
                            tile = copy(t)
                            break
                        end
                        t = rotate(t)
                        if t == tiles[iid]
                            t = flip(t)
                        elseif t == flip(tiles[iid])
                            break
                        end
                    end
                    if f
                        id = iid
                        break
                    end
                end
            end
            ind1 = (i-1)*M+1
            ind2 = (j-1)*M+1
            img[ind1:ind1+M-1, ind2:ind2+M-1] = tile[2:1+M, 2:1+M]
            lastpadding = tile[:,end]
            paddings[j] = tile[end,:]
            delete!(tiles, id)
        end
    end
    
    work = copy(img)
    
    pattern = 
"""                  # 
#    ##    ##    ###
 #  #  #  #  #  #   """
    dragon = permutedims(hcat(collect.(split(pattern, "\n"))...), (2,1))
    num = 0
    while true
        for i = 1:N*M-2, j = 1:N*M-19
            match = true
            for a = 1:3, b = 1:20
                if dragon[a,b] == '#' && work[i+a-1,j+b-1] != '#'
                    match = false
                    break
                end
            end
            if match
                num -= count(c->c=='#', dragon)
            end
        end
        work = rotate(work)
        if work == img
            work = flip(work)
        elseif work == flip(img)
            break
        end
    end
    num + count(c->c=='#', img)
end
