using CircularList # https://github.com/tk3369/CircularList.jl

# returns solution of part 1
function x()
    vec = parse.(Int, collect("318946572"))
    cups = circularlist(vec)
    
    for i=1:100
        curr = current(cups)
        val = curr.data
        nexts = []
        for j=1:3
            forward!(cups)
            push!(nexts, current(cups).data)
            delete!(cups)
        end
        dst = undef
        found = false
        x = val
        while !found
            x -= 1
            if x == 0
                x = 9
            end
            start = current(cups)
            forward!(cups)
            while current(cups).data != start.data
                if current(cups).data == x
                    found = true
                    dst = current(cups)
                    break
                end
                forward!(cups)
            end
        end
        jump!(cups, dst)
        for j=1:3
            insert!(cups, nexts[j])
        end
        jump!(cups, curr)
        forward!(cups)
    end
    while current(cups).data != 1
    	forward!(cups)
    end
    join(collect(cups)[2:end], "")
end

## too slow; efficient solution for part 2 in C
function y()
    max = 9
    vec = parse.(Int, collect("389125467"))
    cups = circularlist(vec)
    backward!(cups)
    for i = length(vec)+1 : max
        insert!(cups, i)
    end
    forward!(cups)
    #println("constructed")
    
    for i=1:100
        if i % 1000 == 0
            println(i)
        end
        curr = current(cups)
        val = curr.data
        nexts :: Array{Int, 1} = []
        for j=1:3
            forward!(cups)
            push!(nexts, current(cups).data)
            delete!(cups)
        end
        #println(nexts)
        #println(cups)
        dst = undef
        found = false
        x = val - 1
        if x == 0
            x = max
        end
        while x in nexts
            x -= 1
            if x == 0
                x = max
            end
        end
        start = current(cups)
        forward!(cups)
        while current(cups).data != start.data
            if current(cups).data == x
                dst = current(cups)
                break
            end
            forward!(cups)
        end
        #println(dst)
        jump!(cups, dst)
        for j=1:3
            insert!(cups, nexts[j])
        end
        jump!(cups, curr)
        forward!(cups)
        #println(cups)
    end
    while true
        if current(cups).data == 1
            forward!(cups)
            x = current(cups).data
            forward!(cups)
            y = current(cups).data
            return x*y
        end
        forward!(cups)
    end
    
end
