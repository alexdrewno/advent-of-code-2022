function solvePartOne(inputPath)
    lines = readlines(inputPath)
    total = 0

    for line in lines
        movesSplit = split(line, " ")
        opponentMoveKey = movesSplit[1]
        userMoveKey = movesSplit[2]

        userMove = getUserMove(userMoveKey)
        opponentMove = getOpponentMove(opponentMoveKey)

        result = getResult(userMove, opponentMove)

        total += getPointsForResult(result)
        total += getPointsForMove(userMove)
    end

    return total
end

function solvePartTwo(inputPath)
    lines = readlines(inputPath)
    total = 0

    for line in lines
        opponentMoveAndResult = split(line, " ")
        opponentMoveKey = opponentMoveAndResult[1]
        resultKey = opponentMoveAndResult[2]

        necessaryResult = getNecessaryResult(resultKey)
        opponentMove = getOpponentMove(opponentMoveKey)

        requiredMove = getRequiredMove(opponentMove, necessaryResult)

        total += getPointsForResult(necessaryResult)
        total += getPointsForMove(requiredMove)
    end

    return total
end

function getResult(userMove, opponentMove)
    if (userMove === opponentMove)
        return "DRAW"
    elseif (userMove === "ROCK" && opponentMove === "SCISSORS")
        return "WIN"
    elseif (userMove === "PAPER" && opponentMove === "ROCK")
        return "WIN"
    elseif (userMove === "SCISSORS" && opponentMove === "PAPER")
        return "WIN"
    else 
        return "LOSE"
    end 
end

function getPointsForResult(result)
    resultsPoints = Dict("WIN" => 6, "DRAW" => 3, "LOSE" => 0)

    return resultsPoints[result]
end 

function getRequiredMove(opponentMove, requiredResult) 
    # Logic for each result
    # i.e. if opponent did "ROCK" we can play
    # SCISSORS to lose, PAPER to win, ROCK to draw
    moveLogicDict = Dict(
        "ROCK" => Dict(
            "LOSE" => "SCISSORS",
            "WIN" => "PAPER",
            "DRAW" => "ROCK",
        ),
        "PAPER" => Dict(
            "LOSE" => "ROCK",
            "WIN" => "SCISSORS",
            "DRAW" => "PAPER",
        ),
        "SCISSORS" => Dict(
            "LOSE" => "PAPER",
            "WIN" => "ROCK",
            "DRAW" => "SCISSORS",
        ),
    )

    # Get the results based off of the opponent move
    resultsForOpponentMove = moveLogicDict[opponentMove]

    # Get the move for the necessary result
    return resultsForOpponentMove[requiredResult]
end

function getUserMove(userMoveKey) 
    userMoves = Dict("X" => "ROCK", "Y" => "PAPER", "Z" => "SCISSORS")

    return userMoves[userMoveKey]
end

function getOpponentMove(opponentMoveKey) 
    opponentMoves = Dict("A" => "ROCK", "B" => "PAPER", "C" => "SCISSORS")

    return opponentMoves[opponentMoveKey]
end

function getNecessaryResult(resultKey)
    results = Dict("X" => "LOSE", "Y" => "DRAW", "Z" => "WIN")

    return results[resultKey]
end


function getPointsForMove(userMoveKey) 
    userMovePoints = Dict("ROCK" => 1, "PAPER" => 2, "SCISSORS" => 3)
    
    return userMovePoints[userMoveKey]
end

println(solvePartOne("./input.txt"))
println(solvePartTwo("./input.txt"))
