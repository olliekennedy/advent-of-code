package year2024.day7


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val equations = parse(input)

    var total = 0L

    equations.map { it: Pair<Long, List<Long>> ->
        val testValue = it.first
        val numbers = it.second

        total += adaptiveSum(numbers, 0, testValue)
    }

    val totalPart1 = total
    println("Part 1: $totalPart1")

    total = 0L

    equations.map { it: Pair<Long, List<Long>> ->
        val testValue = it.first
        val numbers = it.second

        total += adaptiveSum2(numbers, 0, testValue)
    }

    println("Part 2: $total")
}

fun adaptiveSum(numbers: List<Long>, sumTilNow: Long, target: Long): Long {
    if (numbers.size > 1) {
        val additionChain = adaptiveSum(numbers.subList(1, numbers.size), sumTilNow + numbers[0], target)
        val multiplyChain = adaptiveSum(numbers.subList(1, numbers.size), sumTilNow * numbers[0], target)
        return if (additionChain == target || multiplyChain == target) target else 0
    } else if (numbers.size == 1) {
        val additionChain = sumTilNow + numbers[0]
        val multiplyChain = sumTilNow * numbers[0]
        return if (additionChain == target || multiplyChain == target) target else 0
    } else {
        return 0
    }
}

fun adaptiveSum2(numbers: List<Long>, sumTilNow: Long, target: Long): Long {
    val nextNumber = numbers[0]
    val sum = sumTilNow + nextNumber
    val multiplication = (if (sumTilNow == 0L) 1L else sumTilNow) * nextNumber
    val concatenation = "$sumTilNow$nextNumber".toLong()

    return when {
        numbers.size > 1 -> {
            val additionChain = adaptiveSum2(numbers.subList(1, numbers.size), sum, target)
            val multiplyChain = adaptiveSum2(numbers.subList(1, numbers.size), multiplication, target)
            val concatChain = adaptiveSum2(numbers.subList(1, numbers.size), concatenation, target)

            if (additionChain == target || multiplyChain == target || concatChain == target) target else 0
        }
        numbers.size == 1 -> {
            if (sum == target || multiplication == target || concatenation == target) target else 0
        }
        else -> {
            throw ProgrammingError()
        }
    }
}

class ProgrammingError : Throwable()

private fun parse(input: String) = input
    .split("\n")
    .map { it.split(": ") }
    .map { it[0].toLong() to it[1].split(" ").map { it.toLong() } }
