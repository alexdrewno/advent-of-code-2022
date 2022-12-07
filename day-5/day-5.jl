using DataStructures

function solvePartOne(inputPath)
    s = open(inputPath) do file
        read(file, String)
    end

    initialStateAndMoves = split(s, "\n\n")
    boardState = initialStateAndMoves[1]
    permutations = initialStateAndMoves[2]

    arrayOfStacks = parseBoard(boardState)
    doPermutations!(arrayOfStacks, permutations)

    ans = ""

    for stack in arrayOfStacks
        ans *= first(stack)
    end

    return ans
end

function solvePartTwo(inputPath)
    s = open(inputPath) do file
        read(file, String)
    end

    initialStateAndMoves = split(s, "\n\n")
    boardState = initialStateAndMoves[1]
    permutations = initialStateAndMoves[2]

    arrayOfStacks = parseBoard(boardState)
    doPermutationsPartTwo!(arrayOfStacks, permutations)

    ans = ""

    for stack in arrayOfStacks
        ans *= first(stack)
    end

    return ans

end

function parseBoard(boardString)
    boardStringLines = split(boardString, "\n")
    arrayOfStacks = Stack{String}[]
    numStacks = length(boardStringLines[1]) ÷ 4 + 1

    for _ in 1:numStacks
        push!(arrayOfStacks, Stack{String}())
    end

    for rowIndex in 1:length(boardStringLines)-1
        line = boardStringLines[length(boardStringLines)-rowIndex]

        for i in 1:numStacks
            index = (i - 1) * 4 + 2
            curSymbol = line[index:index]

            if curSymbol != " "
                push!(arrayOfStacks[i], line[index:index])
            end
        end
    end
    return arrayOfStacks
end

function doPermutations!(arrayOfStacks, permutations)
    for line in split(permutations, '\n')
        if (length(line) > 0)
            permArr = split(line, ' ')

            numToMove = parse(Int64, permArr[2])
            source = parse(Int64, permArr[4])
            destination = parse(Int64, permArr[6])

            for _ in 1:numToMove
                push!(arrayOfStacks[destination], pop!(arrayOfStacks[source]))
            end
        end
    end
end

function doPermutationsPartTwo!(arrayOfStacks, permutations)
    for line in split(permutations, '\n')
        if (length(line) > 0)
            permArr = split(line, ' ')

            numToMove = parse(Int64, permArr[2])
            source = parse(Int64, permArr[4])
            destination = parse(Int64, permArr[6])

            poppedItems = Stack{String}()

            for _ in 1:numToMove
                poppedItem = pop!(arrayOfStacks[source])
                push!(poppedItems, poppedItem)
            end

            while !isempty(poppedItems)
                push!(arrayOfStacks[destination], pop!(poppedItems))
            end
        end
    end
end

println(solvePartOne("input.txt"))
println(solvePartTwo("input.txt"))
