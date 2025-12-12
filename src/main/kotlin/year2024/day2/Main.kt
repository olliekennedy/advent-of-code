package year2024.day2



fun main() {
    compute(TEST_INPUT)
    compute(PUZZLE_INPUT)
}

private fun compute(input: String) {
    val reports = input.split("\n").map { report ->
        report.split(" ").map { level -> level.toInt() }
    }

    val safeCount = reports
        .map { it.isSafe() }
        .count { it }

    println("Part 1: $safeCount")

    val safeWithDampenerCount = reports
        .map { it.safeWithDampener() }
        .count { it }

    println("Part 2: $safeWithDampenerCount")
}

private fun List<Int>.safeWithDampener(): Boolean {
    if (this.isSafe()) return true

    this.indices.map {
        if (this.removeElement(it).isSafe()) return true
    }

    return false
}

private fun List<Int>.removeElement(it: Int): List<Int> {
    val mut = this.toMutableList()
    mut.removeAt(it)
    return mut
}

private fun List<Int>.isSafe(): Boolean {
    val increasing = this[1] - this[0] > 0

    this.indices.drop(1).forEach {
        val difference = if (increasing) {
            this[it] - this[it - 1]
        } else {
            this[it - 1] - this[it]
        }

        if (difference !in 1..3) return false
    }

    return true
}
