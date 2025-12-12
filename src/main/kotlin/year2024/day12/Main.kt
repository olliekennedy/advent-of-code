package year2024.day12


fun main() {
    println("Test:")
    computePart2(TEST_INPUT)
//    println("Test2:")
//    compute(TEST_INPUT_2)
//    println("Test3:")
//    compute(TEST_INPUT_3)
//    computePart2(TEST_INPUT_3)
//    1450432 too low
    println("Puzzle:")
    computePart2(PUZZLE_INPUT)
}

val neighbours = listOf(0 to -1, 1 to 0, 0 to 1, -1 to 0)

var accountedFor = mutableSetOf<Pair<Int, Int>>()

var twoDeeMap = listOf<List<String>>()

private fun compute(input: String) {

    accountedFor = emptySet<Pair<Int, Int>>().toMutableSet()

    twoDeeMap = input.split("\n").map { it.split("").filter { it.isNotEmpty() } }

//    var counter = 0
//    for (line in twoDeeMap) {
//        for (char in line) {
//            print("$char ")
//            counter++
//        }
//        println()
//    }

    val totals = mutableListOf<Pair<String, Pair<Int, Int>>>()

    for (j in twoDeeMap.indices) {
        for (i in twoDeeMap[0].indices) {
            if (i to j in accountedFor) continue

            val target = twoDeeMap[j][i]
            val theseLocations: List<Pair<Int, Int>> = checkLoc(twoDeeMap, i to j, mutableListOf(), target)

            println("Target: $target")
            println(theseLocations)


            val area = theseLocations.size
//            println("$target Area: $area")
            val perimeter = calculatePerimeter(theseLocations)
//            println("$target Perimeter: $perimeter")
            totals.add(target to (area to perimeter))
        }
    }

//    println(totals)

//    println("Diff: ${accountedFor.size - counter}")

    val part1 = totals.sumOf { it.second.first * it.second.second }

//    println(totals.sumOf { it.second.first })

    println("Part 1: $part1")
}


private fun computePart2(input: String) {

    accountedFor = emptySet<Pair<Int, Int>>().toMutableSet()

    val twoDeeMap = input.split("\n").map { it.split("").filter { it.isNotEmpty() } }

    val totals = mutableListOf<Pair<String, Pair<Int, Int>>>()

    for (j in twoDeeMap.indices) {
        for (i in twoDeeMap[0].indices) {
            if (i to j in accountedFor) continue

            val target = twoDeeMap[j][i]
            val theseLocations: List<Pair<Int, Int>> = checkLoc(twoDeeMap, i to j, mutableListOf(), target)

//            println("Target: $target")
//            println(theseLocations)


            val area = theseLocations.size
            val perimeter = calculatePerimeterSides(theseLocations)
            totals.add(target to (area to perimeter))
        }
    }


    val part2 = totals.sumOf { it.second.first * it.second.second }

//    println(totals.sumOf { it.second.first })

    println("Part 2: $part2")
}

private fun calculatePerimeter(locations: List<Pair<Int, Int>>) =
    locations.sumOf { location: Pair<Int, Int> ->
        neighbours.count { neighbour: Pair<Int, Int> ->
            (location.first + neighbour.first to location.second + neighbour.second) !in locations
        }
    }

private fun calculatePerimeterSides(locations: List<Pair<Int, Int>>): Int {
    val someMap = locations.associateWith { location: Pair<Int, Int> ->
        neighbours.filter { neighbour: Pair<Int, Int> ->
            (location.first + neighbour.first to location.second + neighbour.second) !in locations
        }
    }

    var perimeter = locations.sumOf { location: Pair<Int, Int> ->
        neighbours.count { neighbour: Pair<Int, Int> ->
            (location.first + neighbour.first to location.second + neighbour.second) !in locations
        }
    }

    for (thing in someMap) {
        for (direction in thing.value) {
            val otherCellsWithThatDirection = someMap.filter { direction in it.value }
            for (cell in otherCellsWithThatDirection) {
                val nextDirection = neighbours[(neighbours.indexOf(direction) + 1) % neighbours.size]
                val pair = thing.key.first + nextDirection.first to thing.key.second + nextDirection.second
                if (pair in someMap.keys && direction in someMap[pair]!!) {
                    perimeter--
                    break
                }
            }
        }
    }

    return perimeter
}

private fun checkLoc(
    twoDeeMap: List<List<String>>,
    location: Pair<Int, Int>,
    locations: List<Pair<Int, Int>>,
    target: String,
): List<Pair<Int, Int>> {
    if (location.first >= twoDeeMap[0].size || location.second >= twoDeeMap.size) return locations
    if (location.first < 0 || location.second < 0) return locations
    if (location in accountedFor) return locations
    if (twoDeeMap[location.second][location.first] != target) return locations

    var newLocations = locations.toMutableList()

    newLocations.add(location)
    accountedFor.add(location)

    for (neighbour in neighbours) {
        newLocations = checkLoc(twoDeeMap, location.first + neighbour.first to location.second + neighbour.second, newLocations, target).toMutableList()
    }

    return newLocations
}
