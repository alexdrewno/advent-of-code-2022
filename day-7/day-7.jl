using DataStructures

function solvePartOne(inputPath)
    lines = readlines(inputPath)
    directories = parseDirectories(lines)
    directorySums = sumDirectories(directories)
    return getAnswer(directorySums, 100000)
end

function solvePartTwo(inputPath)
    lines = readlines(inputPath)

    directories = parseDirectories(lines)
    directorySums = sumDirectories(directories)

    return getAnswerPartTwo(directorySums)
end

function parseDirectories(lines)
    # parse directories
    directories = Dict("/" => Dict())
    parents = Stack{Dict}() 
    curDirectory = directories["/"] 

    for line in lines[2:length(lines)]
        command = split(line, ' ')

        if command[1][1] == '$'
            if command[2] == "cd"
                if (command[3] == "..")
                    curDirectory = pop!(parents)
                elseif (command[3] in keys(curDirectory))
                    push!(parents, curDirectory)
                    curDirectory = curDirectory[command[3]]
                else 
                    push!(parents, curDirectory)
                    curDirectory[command[3]] = Dict()
                    curDirectory = curDirectory[command[3]]
                end
            end
        elseif command[1] == "dir"
            if !(command[2] in keys(curDirectory))
            end
        else 
            curDirectory[command[2]] = parse(Int64, command[1])
        end
    end

    return directories
end

function sumDirectories(directories)
    #sum directories and children
    directorySums = Dict()

    function sumDirectory(directoryPath, directory)
        sum = 0

        if directoryPath in keys(directorySums)
            return directorySums[directoryPath]
        end
        
        for key in keys(directory)
            if typeof(directory[key]) == Dict{Any, Any}
                sum += sumDirectory(directoryPath * "/" * key, directory[key])
            else 
                sum += directory[key]
            end
        end
    
        directorySums[directoryPath] = sum

        return sum
    end

    sumDirectory("/", directories["/"])
    
    return directorySums
end

function getAnswer(directorySums, n)
    sum = 0

    for key in keys(directorySums)
        if directorySums[key] <= n
            sum += directorySums[key]
        end
    end

    return sum
end

function getAnswerPartTwo(directorySums)
    # given by prompt
    MAX_VALUE = 70000000
    MIN_NEEDED_VALUE = 30000000
    freeSpace = MAX_VALUE - directorySums["/"]
    neededSpace = MIN_NEEDED_VALUE - freeSpace
    
    minFound = MAX_VALUE

    for key in keys(directorySums)
        if directorySums[key] >= neededSpace && directorySums[key] < minFound
            minFound = directorySums[key]
        end
    end

    return minFound
end



println(solvePartOne("input.txt"))
println(solvePartTwo("input.txt"))
