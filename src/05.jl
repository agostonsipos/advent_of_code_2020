using DelimitedFiles
function id(str)
	str = replace(str, "F" => "0")
	str = replace(str, "B" => "1")
	str = replace(str, "L" => "0")
	str = replace(str, "R" => "1")
	parse(Int, str, base=2)
end

# prints solution of both parts
function x()
	arr = sort(id.(vec(readdlm("5.txt"))))
	println(maximum(arr))
	for i = 1:length(arr)-1
		if arr[i] + 1 != arr[i+1]
			println(arr[i]+1)
		end
	end
end
