package year2024.day11

import kotlin.time.measureTime


fun main() {
    println("Test:")
    compute(25, TEST_INPUT)
    println("Puzzle:")
    println("Time taken: ${measureTime { compute(75, PUZZLE_INPUT) }}")
}

val memory = mutableMapOf<Pair<Long, Int>, Long>()

private fun compute(blinks: Int, input: String) {
    input
        .split(" ")
        .map { it.toLong() }
        .sumOf { howManyRocks(it, blinks) }
        .also { println("Answer for $blinks blinks: $it") }
}

fun howManyRocks(bit: Long, blinksLeft: Int): Long {
    if (blinksLeft == 0) return 1

    return memory[bit to blinksLeft] ?: when {
        bit == 0L -> howManyRocks(1L, blinksLeft - 1)

        bit.toString().length % 2 == 0 -> {
            val element = bit.toString()
            val length = element.length
            val firstHalf = element.slice(0..<(length / 2)).toLong()
            val secondHalf = element.slice((length / 2)..<length).toLong()

            howManyRocks(firstHalf, blinksLeft - 1) + howManyRocks(secondHalf, blinksLeft - 1)
        }

        else -> howManyRocks(bit * 2024L, blinksLeft - 1)
    }.also {
        memory[bit to blinksLeft] = it
    }
}
