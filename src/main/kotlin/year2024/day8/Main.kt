package year2024.day8

import kotlin.math.abs


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Test2:")
    compute(TEST_INPUT_2)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {

    val twoDeeMap = input.split("\n").map { it.split("").filter { it.isNotEmpty() } }

    val antennaLocations = mutableMapOf<String, MutableSet<Pair<Int, Int>>>()

    val yIntRange = twoDeeMap.indices
    val xIntRange = twoDeeMap[0].indices
    for (y in yIntRange) {
        for (x in xIntRange) {
            val char = twoDeeMap[y][x]
            if (char != ".") {
                antennaLocations.getOrPut(char) { mutableSetOf() }.add(x to y)
            }
        }
    }

    val part1AntinodeLocations = mutableSetOf<Pair<Int, Int>>()

    for (char: String in antennaLocations.keys) {
        for (locationOne: Pair<Int, Int> in antennaLocations[char]!!) {
            for (locationTwo: Pair<Int, Int> in antennaLocations[char]!!) {
                if (locationOne == locationTwo) continue

                val xDiff = locationTwo.first - locationOne.first
                val yDiff = locationTwo.second - locationOne.second

                val possibleAntinodeLocation = (locationTwo.first + xDiff) to (locationTwo.second + yDiff)
                val anotherPossibleAntinodeLocation = (locationOne.first - xDiff) to (locationOne.second - yDiff)

                if (possibleAntinodeLocation.second in yIntRange && possibleAntinodeLocation.first in xIntRange) {
                    part1AntinodeLocations.add(possibleAntinodeLocation)
                }
                if (anotherPossibleAntinodeLocation.second in yIntRange && anotherPossibleAntinodeLocation.first in xIntRange) {
                    part1AntinodeLocations.add(anotherPossibleAntinodeLocation)
                }
            }
        }
    }

    val part1AntinodeCount = part1AntinodeLocations.size

    println("Part 1: $part1AntinodeCount")

    val part2AntinodeLocations = mutableSetOf<Pair<Int, Int>>()

    for (char: String in antennaLocations.keys) {
        for (locationOne: Pair<Int, Int> in antennaLocations[char]!!) {
            for (locationTwo: Pair<Int, Int> in antennaLocations[char]!!) {
                if (locationOne == locationTwo) continue

                val xDiff = (locationTwo.first - locationOne.first).toDouble()
                val yDiff = (locationTwo.second - locationOne.second).toDouble()

                if (xDiff == 0.0) continue

                val slope = yDiff / xDiff

                for (x in twoDeeMap[0].indices) {
                    val summin = x - locationOne.first
                    if (summin == 0) continue
                    val possibleAntinodeYLocation = (summin * slope) + locationOne.second
                    if (abs(possibleAntinodeYLocation % 1.0) < 0.000001) {
                        if (possibleAntinodeYLocation.toInt() in yIntRange) {
                            part2AntinodeLocations.add(x to possibleAntinodeYLocation.toInt())
                        }
                    }
                }
            }
        }
    }

    prettyPrint(twoDeeMap, part2AntinodeLocations)

//    println(part2AntinodeLocations)

    val part2AntinodeCount = part2AntinodeLocations.size

    println("Part 2: $part2AntinodeCount")
}

private fun prettyPrint(twoDeeMap: List<List<String>>, part2AntinodeLocations: MutableSet<Pair<Int, Int>>) {
    for (y in twoDeeMap.indices) {
        for (x in twoDeeMap[0].indices) {
            val char = twoDeeMap[y][x]
            if (char != ".") {
                print(char)
            } else {
                if (x to y in part2AntinodeLocations) {
                    print("#")
                } else {
                    print(".")
                }
            }
        }
        println()
    }
}
