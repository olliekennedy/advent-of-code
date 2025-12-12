package year2024.day3

fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Test2:")
    compute(TEST_INPUT2)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val regex = "mul\\([0-9]{1,3},[0-9]{1,3}\\)"

    val regexPattern = Regex(regex)
    val matches = regexPattern.findAll(input)

    val mulFunctions = matches.map { it.value }.toList()

    val summed = mulFunctions
        .map {
            it
                .replace("mul(", "")
                .replace(")", "")
                .split(",")
                .map { it.toInt() }
                .toList()
        }
        .sumOf { it[0] * it[1] }


    println("Part 1: $summed")

    val newRegexPattern = Regex("mul\\([0-9]{1,3},[0-9]{1,3}\\)|do\\(\\)|don't\\(\\)")
    val newMatches = newRegexPattern.findAll(input)

    val functions = newMatches.map { it.value }.toMutableList()

    var i = 0
    var enabled = true
    while (i < functions.size) {
        when {
            functions[i].startsWith("don't()") -> {
                enabled = false
                functions.removeAt(i)
            }

            functions[i].startsWith("do()") -> {
                enabled = true
                functions.removeAt(i)
            }

            functions[i].startsWith("mul(") -> {
                if (!enabled) {
                    functions.removeAt(i)
                } else {
                    i++
                }
            }
        }
    }

    val newSummed = functions
        .map {
            it.replace("mul(", "")
                .replace(")", "")
                .split(",")
                .map { it.toInt() }
                .toList()
        }.sumOf { it[0] * it[1] }

    println("Part 2: $newSummed")
}
