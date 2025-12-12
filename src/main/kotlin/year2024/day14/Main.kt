package year2024.day14


fun main() {
//    println("Test:")
//    compute(TEST_INPUT)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

const val X_SIZE = 101
const val Y_SIZE = 103
const val TIME = 100


private fun compute(input: String) {

    val robots = input.split("\n").map {
        it.split(" ").let {
            Robot(
                it[0].replace("p=", "").split(",").map { it.toInt() }.let { Coordinate(it[0], it[1]) },
                it[1].replace("v=", "").split(",").map { it.toInt() }.let { Velocity(it[0], it[1]) },
            )
        }
    }
    val after100Seconds = hundredSeconds(robots, TIME)
    println("****************")
    var newRobots = oneSecond(robots, 1)
    repeat(10000) {
        newRobots = oneSecond(newRobots, 1)
        val coords: List<Pair<Int, Int>> = newRobots.map { it.initial.x to it.initial.y }
        var rising = 0
        for (coord in coords) {
            if (coord.first+1 to coord.second-1 in coords) {
                rising += 1
            }
        }
        if (rising > 100) {
            println(printRobotLocations(newRobots.map { it.initial }))
            println("Blink: $it")
            Thread.sleep(1000)
        }
    }

//        .also { it.map { println(it) }}

//    printRobotLocations(positionsAfter)

    val nw = after100Seconds.filter {
        (it.x <= ((X_SIZE - 1) / 2) - 1) &&
            (it.y <= ((Y_SIZE - 1) / 2) - 1)
    }
    val ne = after100Seconds.filter {
        (it.x >= ((X_SIZE - 1) / 2) + 1) &&
            (it.y <= ((Y_SIZE - 1) / 2) - 1)
    }
    val sw = after100Seconds.filter {
        (it.x <= ((X_SIZE - 1) / 2) - 1) &&
            (it.y >= ((Y_SIZE - 1) / 2) + 1)
    }
    val se = after100Seconds.filter {
        (it.x >= ((X_SIZE - 1) / 2) + 1) &&
            (it.y >= ((Y_SIZE - 1) / 2) + 1)
    }
    val quadrants = listOf(nw, ne, sw, se)
//        .also { it.map { println(it) } }
    val safetyFactor = quadrants.map { it.count() }.fold(1) { acc, elem -> acc * elem }
//        .also { println("it = ${it}") }

    println("Part 1: $safetyFactor")

//    println("Part 2: $total")
}

private fun hundredSeconds(robots: List<Robot>, time: Int) = robots.map {
    Coordinate(
        Math.floorMod(it.initial.x + (it.velocity.x * time), X_SIZE),
        Math.floorMod(it.initial.y + (it.velocity.y * time), Y_SIZE),
    )
}

private fun oneSecond(robots: List<Robot>, time: Int): List<Robot> {
    return robots.map {
        it.copy(
            initial = Coordinate(
                Math.floorMod(it.initial.x + (it.velocity.x * time), X_SIZE),
                Math.floorMod(it.initial.y + (it.velocity.y * time), Y_SIZE),
            )
        )
    }
}

private fun printRobotLocations(positionsAfter: List<Coordinate>) {
    (0..<Y_SIZE).map { j: Int ->
        (0..<X_SIZE).map { i: Int ->
            val count = positionsAfter.count { it == Coordinate(i, j) }

            if (count > 0) {
                print("\u2588 ")
            } else {
                print("  ")
            }
        }
        println()
    }
}

data class Robot(
    val initial: Coordinate,
    val velocity: Velocity,
)

data class Coordinate(
    val x: Int,
    val y: Int,
)

data class Velocity(
    val x: Int,
    val y: Int,
)