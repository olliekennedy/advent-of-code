package year2024.day3

import java.io.File

const val TEST_INPUT = """xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"""
const val TEST_INPUT2 = """xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"""

val PUZZLE_INPUT = year2024.day6.getFile()

fun getFile(): String {
    val filePath = "/Users/OKENNED3/code-personal/aoc/src/day3/input.txt"
    val file = File(filePath)

    val fileContent = file.readText()

    return fileContent
}
