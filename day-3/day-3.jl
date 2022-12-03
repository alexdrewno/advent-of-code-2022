
function solvePartOne(inputPath)
    lines = readlines(inputPath)
    sum = 0

    for line in lines
        sum += getSetBitPosition(getCommonLetters(line))
    end

    return sum
end

function solvePartTwo(inputPath)
    lines = readlines(inputPath)

    curBitString::Int64 = typemax(Int64)
    sum = 0
    lineNum = 1


    for line in lines
        curBitString = curBitString & getLetterBitString(line)

        if (lineNum % 3 === 0)
            sum += getSetBitPosition(curBitString)
            curBitString = typemax(Int64)
        end

        lineNum += 1
    end

    return sum
end

## Since there are 52 letters, we can encode if a letter was seen with the bit position
## i.e. seeing an 'a' would set the bit at the first position 0001 
## We can do an & operation at the end to see which letter was seen in both by getting 
## the position of the bit 
function getCommonLetters(line)
    firstBitString::Int64 = 0
    secondBitString::Int64 = 0

    firstPart = SubString(line, 1, Int(length(line) / 2))
    secondPart = SubString(line, Int(length(line) / 2 + 1), length(line))

    # Assuming first part and second part are same length
    for i = 1:(length(firstPart))
        currentFirstPartChar = firstPart[i]
        currentSecondPartChar = secondPart[i]

        firstPartBit = getBitPositionToSet(currentFirstPartChar)
        secondPartBit = getBitPositionToSet(currentSecondPartChar)

        firstBitString = setNthBit(firstBitString, firstPartBit)
        secondBitString = setNthBit(secondBitString, secondPartBit)
    end

    return firstBitString & secondBitString
end

## Get the bit string of letters that we have seen, i.e. if we have seen 'a' and 'c' we would return 0101
function getLetterBitString(line)
    bitString::Int64 = 0

    for i = 1:(length(line))
        currentChar = line[i]
        bitPosition = getBitPositionToSet(currentChar)
        bitString = setNthBit(bitString, bitPosition)
    end

    return bitString
end

function getBitPositionToSet(currentChar)
    ## 'a' is greater than 'A'
    if (Int(currentChar) >= Int('a'))
        # 'a' should map to 1
        return Int(currentChar) - Int('a') + 1
    else
        # 'A' should map to 27
        return Int(currentChar) - Int('A') + 27
    end
end

function getSetBitPosition(bitString)
    ## This gets the position of the bit
    return Int(log2(bitString) + 1)
end

function setNthBit(bits, n)
    return bits |= 2^(n - 1)
end

# println(solvePartOne("input.txt"))
println(solvePartTwo("input.txt"))
