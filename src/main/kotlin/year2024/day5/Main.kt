package year2024.day5

import kotlin.math.floor


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val split = input.split("\n\n")

    val rules = split[0].split("\n").map { it.split("|").map { it.toInt() } }
    val updates = split[1].split("\n").map { it.split(",").map { it.toInt() } }

    val validUpdates = mutableListOf<List<Int>>()
    val incorrectUpdates = mutableListOf<List<Int>>()

    for (update in updates) {
        var updateValid = true

        for (i in update.indices) {
            val pagesThatCannotBeUpdatedAfter: List<Int> = rules.filter { it[1] == update[i] }.map { it[0] }
            if (update.slice(i..<update.size).intersect(pagesThatCannotBeUpdatedAfter.toSet()).isNotEmpty()) {
                updateValid = false
                break
            }
        }
        if (updateValid) {
            validUpdates.add(update)
        } else {
            incorrectUpdates.add(update)
        }
    }

    val sumOfMiddlePages = validUpdates.sumOf { it[floor(it.size / 2.0).toInt()] }

    println("Part 1: $sumOfMiddlePages")

    val correctedUpdates = mutableListOf<List<Int>>()

    for (update in incorrectUpdates) {
        val newUpdate = update.toMutableList()
        var i = 0
        while (i < update.size) {
            val pagesThatCannotBeUpdatedAfter: List<Int> = rules.filter { it[1] == newUpdate[i] }.map { it[0] }
            val intersect = newUpdate.slice(i..<newUpdate.size).intersect(pagesThatCannotBeUpdatedAfter.toSet())
            if (intersect.isNotEmpty()) {
                for (wrongPage in intersect) {
                    newUpdate.remove(wrongPage)
                    newUpdate.add(i, wrongPage)
                }
                i = 0
            } else {
                i++
            }
        }
        correctedUpdates.add(newUpdate)
    }

    val sumOfMiddlePagesPart2 = correctedUpdates.sumOf { it[floor(it.size / 2.0).toInt()] }


    println("Part 2: $sumOfMiddlePagesPart2")
}
