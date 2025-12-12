package year2024.day6

import kotlin.system.exitProcess
import kotlin.time.measureTimedValue

val DIRECTIONS = listOf(0 to -1, 1 to 0, 0 to 1, -1 to 0)


fun main() {
    val runEverything = true
    val testAnswer = runAndPrint(TEST_INPUT)
    assertCorrect(testAnswer, 41, 6)
    if (runEverything) {
        val puzzleAnswer = runAndPrint(PUZZLE_INPUT)
        assertCorrect(puzzleAnswer, 5086, 1770)
    }
}

private fun assertCorrect(testAnswer: Pair<Int, Int>, part1: Int, part2: Int) {
    if (testAnswer.first != part1 || testAnswer.second != part2) {
        exitAngrily()
    }
}

private fun runAndPrint(input: String): Pair<Int, Int> {
    val (testAnswer, timetaken) = measureTimedValue { compute(input, printing = false) }
    println("Part 1: ${testAnswer.first}")
    println("Part 2: ${testAnswer.second}")
    println("    in $timetaken")
    return testAnswer
}

private fun exitAngrily(): Nothing {
    val redColor = "\u001B[31m"
    val resetColor = "\u001B[0m"
    val text = "IT'S BROKEN, PANIC!!!!!!!!!!!!!!"

    print("$redColor$text$resetColor")
    exitProcess(1)
}

private fun compute(input: String, printing: Boolean): Pair<Int, Int> {
    val twoDeeMap = parse(input)

    val obstacles = mutableListOf<Pair<Int, Int>>()
    var guardStartingPosition = 0 to 0

    for (j in twoDeeMap.indices) {
        for (i in twoDeeMap[0].indices) {
            if (twoDeeMap[j][i] == "#") {
                obstacles.add(i to j)
            }
            if (twoDeeMap[j][i] == "^") {
                guardStartingPosition = i to j
            }
        }
    }

    var guardDirection = 0 to -1
    var guardLocation: Pair<Int, Int> = guardStartingPosition

    val distinctPositions = mutableSetOf(guardLocation)
    val positionsWithDirection = mutableSetOf(guardLocation to guardDirection)
    val possibleObstacles = mutableSetOf<Pair<Int, Int>>()
    val mapXIndices = 0..<twoDeeMap[0].size
    val mapYIndices = 0..<twoDeeMap.size
    while (true) {
        if (guardLocation.first !in mapXIndices || guardLocation.second !in mapYIndices) {
            break
        }

        val locationInFrontOfGuard =
            guardLocation.first + guardDirection.first to guardLocation.second + guardDirection.second

        distinctPositions.add(guardLocation)
        positionsWithDirection.add(guardLocation to guardDirection)

        if (locationInFrontOfGuard in obstacles) {
            guardDirection = guardDirection.rotate()
        } else {
            guardLocation = locationInFrontOfGuard
        }
    }

    val distinctPositionsCount = distinctPositions.size

    for (position in distinctPositions) {
        val subObstacles = obstacles.toMutableList()
        subObstacles.add(position)
        var subGuardLocation = guardStartingPosition.copy()
        var subGuardDirection = 0 to -1
        val subPositionsWithDirection = mutableSetOf(guardLocation to guardDirection)


        while (true) {
            val firstTing = subGuardLocation.first + subGuardDirection.first
            val secondTing = subGuardLocation.second + subGuardDirection.second
            val subLocationInFrontOfGuard = Pair(firstTing, secondTing)


            if (subLocationInFrontOfGuard in subObstacles) {
                subGuardDirection = subGuardDirection.rotate()
            } else if (subLocationInFrontOfGuard.first !in mapXIndices || subLocationInFrontOfGuard.second !in mapYIndices) {
                break
            } else if (subLocationInFrontOfGuard to subGuardDirection in subPositionsWithDirection) {
                if (printing) {
                    println(veryPrettyPrint(twoDeeMap, subPositionsWithDirection, mutableSetOf(position)))
                }
                possibleObstacles.add(position)
                break
            } else {
                subGuardLocation = subLocationInFrontOfGuard
                subPositionsWithDirection.add(subGuardLocation to subGuardDirection)
            }
        }
    }

    if (printing) {
        println(veryPrettyPrint(twoDeeMap, positionsWithDirection, possibleObstacles))
    }

    return distinctPositionsCount to possibleObstacles.size
}

private fun parse(input: String) = input.split("\n").map { it.split("").filter { it.isNotEmpty() } }

private fun Pair<Int, Int>.rotate(): Pair<Int, Int> =
    DIRECTIONS[(DIRECTIONS.indexOf(this) + 1) % DIRECTIONS.size]

private fun veryPrettyPrint(
    twoDeeMap: List<List<String>>,
    distinctPositions: Set<Pair<Pair<Int, Int>, Pair<Int, Int>>>,
    possibleNewObstacleLocations: Set<Pair<Int, Int>>,
): String {
    var output = ""
    output += "Pretty Print:\n"
    for (j in twoDeeMap.indices) {
        for (i in twoDeeMap[j].indices) {
            if (i to j in possibleNewObstacleLocations) {
                output += "O"
            } else {
                val indexOfFirst = distinctPositions.indexOfFirst { i to j == it.first }
                val directions = mapOf((0 to -1) to "^", (1 to 0) to ">", (0 to 1) to "v", (-1 to 0) to "<")
                if (indexOfFirst != -1) {
                    output += "${directions[distinctPositions.first { i to j == it.first }.second]}"
                } else {
                    output += twoDeeMap[j][i]
                }
            }
        }
        output += "\n"
    }
    return output
}
