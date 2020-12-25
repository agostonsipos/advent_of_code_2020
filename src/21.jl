# note: "contains" was manually removed from the input as it hinders parsing

struct Food
    ingredients :: Array{String, 1}
    allergens :: Array{String, 1}
end

# prints solution of both parts
function x()
    f = open("21.txt")
    N = 37
    foods = []
    for i=1:N
        l = readline(f)
        (ingr, aller) = split(l, " (")
        ing = split(ingr, " ")
        all = split(aller, ", ")
        all[end] = all[end][1:end-1]
        push!(foods, Food(ing, all))
    end
    
    all = Set{String}()
    for i=1:N
        for a in foods[i].allergens
            push!(all, a)
        end
    end
    
    sus = Set{String}()
    data = Dict{String, Set{String}}()
    for a in all
        s = Set{String}()
        f = false
        for i = 1:N
            if a in foods[i].allergens
                if f
                    t = Set{String}()
                    for x in foods[i].ingredients
                        push!(t, x)
                    end
                    intersect!(s, t)
                else
                    for x in foods[i].ingredients
                        push!(s, x)
                    end
                    f = true
                end
            end
        end
        union!(sus, s)
        data[a] = s
    end
    
    c = 0
    for food in foods
        for ing in food.ingredients
            if !(ing in sus)
                c += 1
            end
        end
    end
    println(c)
    
    arr = Array{Tuple{String,String},1}()
    i = 0
    while i < length(all)
        for (k,v) in data
            if length(v) == 1
                v0 = first(v)
                push!(arr, (k, v0))
                for (k1, v1) in data
                    delete!(v1, v0)
                end
                i += 1
            end
        end
    end
    join(map(x->x[2], sort(arr)), ",")
end

