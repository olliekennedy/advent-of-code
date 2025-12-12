package year2024.day16


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Test2:")
    compute(TEST_INPUT_2)
//    println("Puzzle:")
//    compute(PUZZLE_INPUT)
}

val DIRECTIONS = listOf(
    0 to -1, // up
    1 to 0, // right
    0 to 1, // down
    -1 to 0 // left
)

private fun Pair<Int, Int>.clockwise(): Pair<Int, Int> =
    DIRECTIONS[(DIRECTIONS.indexOf(this) + 1) % DIRECTIONS.size]

private fun Pair<Int, Int>.counterClockwise(): Pair<Int, Int> =
    DIRECTIONS[(DIRECTIONS.indexOf(this) + 3) % DIRECTIONS.size]

private fun compute(input: String) {

    val twoDeeMap = input.split("\n").map { it.split("").filter { it.isNotEmpty() } }

    val walls = mutableSetOf<Pair<Int, Int>>()
    var start = -1 to -1
    var end = -2 to -2

    twoDeeMap.indices.map { j ->
        twoDeeMap[0].indices.map { i ->
            when (twoDeeMap[j][i]) {
                "#" -> walls.add(i to j)
                "S" -> start = i to j
                "E" -> end = i to j
                else -> Unit
            }
        }
    }

    val direction = 1 to 0

    val seenPositions = setOf<Pair<Pair<Int, Int>, Pair<Int, Int>>>()
    val scores = tryToMove(position = start, direction = direction, walls = walls, end = end, seenPositions = seenPositions, score = 0)

    val part1 = scores

    println("part1 = ${part1}")
}

private fun tryToMove(
    position: Pair<Int, Int>,
    direction: Pair<Int, Int>,
    walls: MutableSet<Pair<Int, Int>>,
    end: Pair<Int, Int>,
    seenPositions: Set<Pair<Pair<Int, Int>, Pair<Int, Int>>>,
    score: Int,
): Int? {
    while (true) {
        if (position == end) return score

        val forward = Move(position, direction, 1)
        val clockwise = Move(position, direction.clockwise(), 1001)
        val counterClockWise = Move(position, direction.counterClockwise(), 1001)
        val possibleNextSteps = listOf(forward, clockwise, counterClockWise).filter {
            if (it.toPosition to it.direction in seenPositions) {

            }
            it.toPosition !in walls && it.toPosition to it.direction !in seenPositions
        }

        val seenPositions = seenPositions.plus(position to direction)
        possibleNextSteps.mapNotNull {
            tryToMove(
                position = it.toPosition,
                direction = it.direction,
                walls = walls,
                end = end,
                seenPositions = seenPositions,
                score = score + it.cost
            )
        }
            .also { if (it.isEmpty()) return null }
            .let { return it.min() }
    }
}


data class Move(
    val fromPosition: Pair<Int, Int>,
    val direction: Pair<Int, Int>,
    val cost: Int,
) {
    val toPosition = fromPosition.addedTo(direction)
}

private fun Pair<Int, Int>.addedTo(direction: Pair<Int, Int>): Pair<Int, Int> =
    this.first + direction.first to this.second + direction.second