package year2024.day17

import java.io.File

const val TEST_INPUT = """Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0"""

const val TEST_INPUT_2 = """Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0"""

const val PUZZLE_INPUT = """Register A: 52042868
Register B: 0
Register C: 0

Program: 2,4,1,7,7,5,0,3,4,4,1,7,5,5,3,0"""
//val PUZZLE_INPUT = getFile()

fun getFile(): String {
    val filePath = "/Users/OKENNED3/code-personal/aoc/src/day3/input.txt"
    val file = File(filePath)

    val fileContent = file.readText()

    return fileContent
}
