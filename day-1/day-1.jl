function solve(inputPath)
    # Keep track of our current and highest sums
    highest = 0
    current = 0 

    lines = readlines(inputPath)

    for line in lines
        # If the line is blank, check to see if current is higher. 
        if (line === "")
            if (current > highest)
                highest = current
            end
            
            # Reset current 
            current = 0
        # Otherwise we parse and add it to our current sum
        else 
            current += parse(Int32, line)
        end
    end

    return highest
end

function solvePart2(inputPath)
    # Keep track of the three highest
    highestArr = [0,0,0]
    current = 0

    lines = readlines(inputPath)

    for line in lines
        # If the line is blank, update our array 
        if (line === "")
            updateHighestArr!(highestArr, current)
            
            # Reset current 
            current = 0
        # Otherwise we parse and add it to our current sum
        else 
            current += parse(Int32, line)
        end
    end

    return sum(highestArr)
end 

function updateHighestArr!(highestArr, current) 
    # Add the value to our array
    push!(highestArr, current)

    # Get the index of the min val
    minVal = minimum(highestArr)
    indexOfMin = findfirst(isequal(minVal), highestArr)

    # Remove the min val
    deleteat!(highestArr, indexOfMin)
end

println(solve("./day-1-input.txt"))
println(solvePart2("./day-1-input.txt"))
