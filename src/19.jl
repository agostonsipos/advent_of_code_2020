# note: grammar was manually brought to Chomsky normal form, as there were only 2 rules to be modified

function parseRule(str)
    a = split(str, ": ")
    parent = parse(Int64, a[1])
    children = a[2]
    options = []
    for rhs in split(children, " | ")
        r = []
        for child in split(rhs, " ")
            try
                push!(r, parse(Int64, child))
            catch
                push!(r, child[2:end-1])
            end
        end
        println(r)
        @assert(length(r) == 2 || r[1][1] == 'a' || r[1][1] == 'b')
        push!(options, r)
    end
    (parent, options)
end

function findParent(rules, rhs)
    try
        return rules[rhs]
    catch
        return []
    end
    parents = []
    for rule in rules
        for r in rule[2]
            if r == rhs
                push!(parents, rule[1])
            end
        end
    end
    parents
end

# prints solution of any part, if the appropriate modification is made in the input
function x()
    f = open("19.txt")
    rules = Dict{Array{Any,1}, Array{Int64,1}}()
    for i=1:139
        rule = parseRule(readline(f))
        for rhs in rule[2]
            rules[rhs] = push!(get(rules, rhs, []), rule[1])
        end
    end
    println(rules)
    readline(f)
    words = []
    for i=1:490
        push!(words, readline(f))
    end
    println(words)
    
    c = 0
    for word in words
        print(word)
        n = length(word)
        pyramid = []
        lvl1 = Array{Array{Int64,1}}(undef, n)
        fill!(lvl1, [])
        for i=1:n
            lvl1[i] = findParent(rules, [string(word[i])])
        end
        push!(pyramid, lvl1)
        for i=2:n
            lvl = Array{Array{Int64,1}}(undef, n+1-i)
            for j = 1:n+1-i
                lvl[j] = []
                for k = 1:i-1
                    rhs = [pyramid[k][j], pyramid[i-k][j+k]]
                    for a=1:length(rhs[1]), b = 1:length(rhs[2])
                        rh = [rhs[1][a], rhs[2][b]]
                        append!(lvl[j], findParent(rules, rh))
                    end
                end
            end
            push!(pyramid, lvl)
        end
        if 0 in pyramid[end][1]
            println(": OK")
            c += 1
        else
            println()
        end
    end
    c
end
