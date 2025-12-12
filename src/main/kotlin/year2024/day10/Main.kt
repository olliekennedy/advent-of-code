package year2024.day10


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    part2Compute(TEST_INPUT)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
    part2Compute(PUZZLE_INPUT)
}

val DIRECTIONS = listOf(
    0 to -1, // up
    1 to 0, // right
    0 to 1, // down
    -1 to 0 // left
)

private fun compute(input: String) {

    val twoDeeMap = generateTwoDeeMapFrom(input)

    val xIndices = twoDeeMap[0].indices
    val yIndices = twoDeeMap.indices
    val xMax = xIndices.last
    val yMax = yIndices.last

    val trailHeads = mutableMapOf<Pair<Int, Int>, Set<Pair<Int, Int>>>()

    for (j in yIndices) {
        for (i in xIndices) {
            if (twoDeeMap[j][i] != 0) continue

            trailHeads[i to j] = checkPath(i, j, xMax, yMax, twoDeeMap, 1, mutableSetOf())
        }
    }

    val totalNumberOfTrails = trailHeads.values.sumOf { it.size }

    println("Part 1: $totalNumberOfTrails")
}

private fun checkPath(
    i: Int,
    j: Int,
    xMax: Int,
    yMax: Int,
    twoDeeMap: List<List<Int>>,
    howDeepIsYourLove: Int,
    foundNines: Set<Pair<Int, Int>>,
): MutableSet<Pair<Int, Int>> {
    var newFoundNines = foundNines.toMutableSet()

    for (direction in DIRECTIONS) {
        val xLocation = i + direction.first
        val yLocation = j + direction.second

        if (xLocation < 0 || xLocation > xMax || yLocation < 0 || yLocation > yMax) {
            continue
        }

        val valueAtLocation = twoDeeMap[yLocation][xLocation]

        if (valueAtLocation == twoDeeMap[j][i] + 1) {
            if (valueAtLocation == 9) {
                newFoundNines.add(xLocation to yLocation)
            } else {
                newFoundNines = checkPath(xLocation, yLocation, xMax, yMax, twoDeeMap, howDeepIsYourLove + 1, newFoundNines)
            }
        }
    }
    return newFoundNines
}

private fun part2Compute(input: String) {

    val twoDeeMap = generateTwoDeeMapFrom(input)

    val xIndices = twoDeeMap[0].indices
    val yIndices = twoDeeMap.indices
    val xMax = xIndices.last
    val yMax = yIndices.last

    val trailHeads = mutableMapOf<Pair<Int, Int>, List<Pair<Int, Int>>>()

    for (j in yIndices) {
        for (i in xIndices) {
            if (twoDeeMap[j][i] != 0) continue

            trailHeads[i to j] = part2CheckPath(i, j, xMax, yMax, twoDeeMap, mutableListOf())
        }
    }

    val totalNumberOfTrails = trailHeads.values.sumOf { it.size }

    println("Part 2: $totalNumberOfTrails")
}

private fun generateTwoDeeMapFrom(input: String) =
    input.split("\n").map { it.split("").filter { it.isNotEmpty() }.map { it.replace(".", "-10").toInt() } }

private fun part2CheckPath(
    i: Int,
    j: Int,
    xMax: Int,
    yMax: Int,
    twoDeeMap: List<List<Int>>,
    foundNines: List<Pair<Int, Int>>,
): MutableList<Pair<Int, Int>> {
    var newFoundNines = foundNines.toMutableList()

    for (direction in DIRECTIONS) {
        val xLocation = i + direction.first
        val yLocation = j + direction.second

        if (xLocation < 0 || xLocation > xMax || yLocation < 0 || yLocation > yMax) {
            continue
        }

        val valueAtLocation = twoDeeMap[yLocation][xLocation]

        if (valueAtLocation == twoDeeMap[j][i] + 1) {
            if (valueAtLocation == 9) {
                newFoundNines.add(xLocation to yLocation)
            } else {
                newFoundNines = part2CheckPath(xLocation, yLocation, xMax, yMax, twoDeeMap, newFoundNines)
            }
        }
    }
    return newFoundNines
}
