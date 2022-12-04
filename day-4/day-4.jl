function solvePartOne(inputPath)
    lines = readlines(inputPath)
    sum = 0

    for line in lines
        ranges = split(line, ',')

        if (hasContainment(ranges[1], ranges[2]))
            sum += 1
        end
    end

    return sum
end

function solvePartTwo(inputPath)
    lines = readlines(inputPath)
    sum = 0

    for line in lines
        ranges = split(line, ',')

        if (hasOverlap(ranges[1], ranges[2]))
            sum += 1
        end
    end

    return sum
end


function hasContainment(rangeOne, rangeTwo)
    minAndMaxOne = split(rangeOne, '-')
    minAndMaxTwo = split(rangeTwo, '-')

    minOne = parse(Int64, minAndMaxOne[1])
    maxOne = parse(Int64, minAndMaxOne[2])

    minTwo = parse(Int64, minAndMaxTwo[1])
    maxTwo = parse(Int64, minAndMaxTwo[2])

    if (minOne >= minTwo && minOne <= maxTwo && maxOne <= maxTwo && maxOne >= minTwo)
        return true
    elseif (maxTwo <= maxOne && maxTwo >= minOne && minTwo <= maxOne && minTwo >= minOne)
        return true
    else
        return false
    end
end

function hasOverlap(rangeOne, rangeTwo)
    minAndMaxOne = split(rangeOne, '-')
    minAndMaxTwo = split(rangeTwo, '-')

    minOne = parse(Int64, minAndMaxOne[1])
    maxOne = parse(Int64, minAndMaxOne[2])

    minTwo = parse(Int64, minAndMaxTwo[1])
    maxTwo = parse(Int64, minAndMaxTwo[2])

    if (minOne >= minTwo && minOne <= maxTwo)
        return true
    elseif (maxOne <= maxTwo && maxOne >= minTwo)
        return true
    elseif (maxTwo <= maxOne && maxTwo >= minOne)
        return true
    elseif (minTwo <= maxOne && minTwo >= minOne)
        return true
    else
        return false
    end
end

println(solvePartOne("./input.txt"))
println(solvePartTwo("./input.txt"))
