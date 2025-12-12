package year2024.day4



fun main() {
    println("Test:")
    compute(TEST_INPUT)
    println("Puzzle:")
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val lines = input.split("\n")
    val twoDeeMap = lines.map { it.split("").filter { it.isNotBlank() } }

    var occurrences = 0

    val neighbours = listOf(
        -1 to -1, 0 to -1, 1 to -1,
        -1 to  0,          1 to  0,
        -1 to  1, 0 to  1, 1 to  1,
    )

    for (j in 0..<twoDeeMap.size) {
        for (i in 0..<twoDeeMap[0].size) {
            if (twoDeeMap[j][i] == "X") {
                neighbours.map {
                    if (twoDeeMap.elementAtOrNull(j + it.second)?.elementAtOrNull(i + it.first) == "M") {
                        if (twoDeeMap.elementAtOrNull(j + (2 * it.second))?.elementAtOrNull(i + 2 * it.first) == "A") {
                            if (twoDeeMap.elementAtOrNull(j + (3 * it.second))?.elementAtOrNull(i + 3 * it.first) == "S") {
                                occurrences++
                            }
                        }
                    }
                }
            }
        }
    }

    println("Part 1: $occurrences")

    var newOccurrences = 0

    for (j in 0..<twoDeeMap.size) {
        for (i in 0..<twoDeeMap[0].size) {
            if (twoDeeMap[j][i] == "A") {
                val forward: List<String> = listOf(
                    twoDeeMap.elementAtOrNull(j - 1)?.elementAtOrNull(i + 1) ?: "Z",
                    twoDeeMap.elementAtOrNull(j + 1)?.elementAtOrNull(i - 1) ?: "Z",
                )
                val backward: List<String> = listOf(
                    twoDeeMap.elementAtOrNull(j - 1)?.elementAtOrNull(i - 1) ?: "Z",
                    twoDeeMap.elementAtOrNull(j + 1)?.elementAtOrNull(i + 1) ?: "Z",
                )
                if (forward.sorted() == listOf("M", "S") && backward.sorted() == listOf("M", "S")) {
                    newOccurrences++
                }
            }
        }
    }

    println("Part 2: $newOccurrences")
}

private fun prettyPrint(twoDeeMap: List<List<String>>) {
    println("Pretty Print:")
    for (line in twoDeeMap) {
        for (char in line) {
            print("$char ")
        }
        println()
    }
}
