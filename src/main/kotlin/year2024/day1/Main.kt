package year2024.day1

import kotlin.math.abs


fun main() {
    compute(TEST_INPUT)
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val pairs = input.split("\n").map {
        val split = it.split("   ")
        split[0] to split[1]
    }

    val firstList = pairs.map { it.first.toInt() }.sorted()
    val secondList = pairs.map { it.second.toInt() }.sorted()

    val totalDistance = input.split("\n")
        .indices
        .sumOf { abs(firstList[it] - secondList[it]) }

    println("Part 1: $totalDistance")

    val sum = firstList.sumOf { left: Int ->
        left * secondList.count { right: Int -> right == left }
    }

    println("Part 2: $sum")
}