package year2024.day15

fun main() {
//    compute(TEST_INPUT)
//    println("Test2:")
    println("Test:")
    compute(TEST_INPUT_2)
    computePart2(TEST_INPUT_2)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
    computePart2(PUZZLE_INPUT)
//    computePart2(TEST_INPUT_3)


}

val directions = mapOf(
    "^" to (0 to -1),
    ">" to (1 to 0),
    "v" to (0 to 1),
    "<" to (-1 to 0),
)

private fun compute(input: String) {

    val (rawMap, instructions) = input.split("\n\n")
        .let { it[0] to it[1].replace("\n", "").split("").filter { it.isNotEmpty() } }

    val twoDeeMap = rawMap
        .split("\n")
        .map {
            it
                .split("")
                .filter { it.isNotEmpty() }
        }

    val walls = mutableSetOf<Pair<Int, Int>>()
    val boxes = mutableSetOf<Pair<Int, Int>>()
    var robotPosition = 0 to 0
    twoDeeMap.indices.map { j: Int ->
        twoDeeMap[0].indices.map { i: Int ->
            when (twoDeeMap[j][i]) {
                "#" -> walls.add(i to j)
                "O" -> boxes.add(i to j)
                "@" -> robotPosition = i to j
                else -> Unit
            }
        }
    }

    instructions.map {
        val direction = directions[it]!!

        var checking = 1
        while (true) {
            val checkingPosition = robotPosition.addedTo(direction.multipliedBy(checking))
            when (checkingPosition) {
                in walls -> break
                in boxes -> {
                    checking++
                }

                else -> {
                    if (checking != 1) {
                        boxes.remove(robotPosition.addedTo(direction))
                        boxes.add(checkingPosition)
                    }
                    robotPosition = robotPosition.addedTo(direction)
                    break
                }
            }
        }

//        println("*******************************************")
//        println("after instruction = ${it}")
//        prettyPrint(walls, boxes, robotPosition, twoDeeMap)
    }

    val part1 = boxes.sumOf { it.second * 100 + it.first }

    println("Part 1: $part1")
}

private fun computePart2(input: String) {

    val (rawishMap, instructions) =
        input
            .split("\n\n")
            .let {
                Pair(
                    it[0].split("\n").map { it.split("").filter { it.isNotEmpty() } },
                    it[1].replace("\n", "").split("").filter { it.isNotEmpty() }
                )
            }

    var robotPosition = 0 to 0
    val boxes = mutableSetOf<Box>()
    val walls = mutableSetOf<Pair<Int, Int>>()
    rawishMap.indices.map { j: Int ->
        rawishMap[0].indices.map { i: Int ->
            val doubleI = i * 2
            when (rawishMap[j][i]) {
                "#" -> walls.addAll(listOf(doubleI to j, doubleI + 1 to j))
                "O" -> boxes.add(Box(doubleI to j, doubleI + 1 to j))
                "@" -> robotPosition = doubleI to j
                else -> Unit
            }
        }
    }

    for (instruction in instructions) {
        val direction = directions[instruction]!!
        val possibleNewRobotPosition = robotPosition.addedTo(direction)

        if (possibleNewRobotPosition in walls) continue

        val clashingBox = boxes.firstOrNull { possibleNewRobotPosition in listOf(it.left, it.right) }
        if (clashingBox != null) {
            val boxesToShift = tryToMove(clashingBox, direction, boxes, walls, setOf(clashingBox))

            if (boxesToShift.isEmpty()) continue

            boxesToShift.reversed().map {
                boxes.remove(it)
                boxes.add(it.shiftedIn(direction))
            }
        }

        robotPosition = possibleNewRobotPosition
    }

    val part2 = boxes.sumOf { (it.left.second * 100) + it.left.first }
    println("part2 = ${part2}")
}

private fun tryToMove(
    boxInQuestion: Box,
    direction: Pair<Int, Int>,
    boxes: MutableSet<Box>,
    walls: MutableSet<Pair<Int, Int>>,
    boxesToShift: Set<Box> = setOf(boxInQuestion),
): Set<Box> =
    boxInQuestion
        .shiftedIn(direction)
        .also { if (it.doesCollideWith(walls)) return emptySet() }
        .findClashesWith(boxes - boxInQuestion)
        .also { clashes -> if (clashes.isEmpty()) return boxesToShift }
        .flatMap { clashingBox ->
            tryToMove(clashingBox, direction, boxes, walls, boxesToShift + clashingBox)
                .also { boxesToShift -> if (boxesToShift.isEmpty()) return emptySet() }
        }.toSet()

private fun Box.doesCollideWith(walls: Set<Pair<Int, Int>>) =
    (setOf(left, right) intersect walls).isNotEmpty()

private fun Box.findClashesWith(boxes: Set<Box>): List<Box> =
    boxes.filter {
        (it.asPositions() intersect asPositions())
            .isNotEmpty()
    }

private fun Box.asPositions() = setOf(this.left, this.right)

private fun Box.shiftedIn(direction: Pair<Int, Int>) =
    Box(left.addedTo(direction), right.addedTo(direction))

fun prettyPrint(
    walls: MutableSet<Pair<Int, Int>>,
    boxes: MutableSet<Pair<Int, Int>>,
    robotPosition: Pair<Int, Int>,
    twoDeeMap: List<List<String>>,
) {
    twoDeeMap.indices.map { j ->
        twoDeeMap[0].indices.map { i ->
            when (i to j) {
                in walls -> print("#")
                in boxes -> print("O")
                robotPosition -> print("@")
                else -> print(".")
            }
        }
        println()
    }
}

fun prettyPrint2(
    walls: MutableSet<Pair<Int, Int>>,
    boxes: Set<Box>,
    robotPosition: Pair<Int, Int>,
    width: Int,
    height: Int,
) {
    (0..<height).map { j ->
        (0..<width).map { i ->
            val map: List<Pair<Int, Int>> = boxes.map { it.left }
            when (i to j) {
                in walls -> print("#")
                in map -> print("[")
                in boxes.map { it.right } -> print("]")
                robotPosition -> print("@")
                else -> print(".")
            }
        }
        println()
    }
}

private fun Pair<Int, Int>.addedTo(direction: Pair<Int, Int>): Pair<Int, Int> =
    this.first + direction.first to this.second + direction.second

private fun Pair<Int, Int>.multipliedBy(multiplier: Int): Pair<Int, Int> =
    this.first * multiplier to this.second * multiplier

data class Box(
    val left: Pair<Int, Int>,
    val right: Pair<Int, Int>,
)
