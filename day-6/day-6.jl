function solve(inputPath::String, n::Int64)
    s = strip(read(inputPath, String))

    for i in 1:(length(s)-n-1)
        
        curDict = Dict()
        for j in i:i+n-1
            curDict[s[j]] = 1
        end

        if length(curDict) === n
            return i+(n-1)
        end
    end
end

println(solve("./input.txt", 4))
println(solve("./input.txt", 14))
