package year2024.day11

import java.io.File

const val TEST_INPUT = """125 17"""

const val READABLE = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
const val TEST_INPUT_2 = """T.........
...T......
.T........
..........
..........
..........
..........
..........
..........
.........."""

const val PUZZLE_INPUT = """3028 78 973951 5146801 5 0 23533 857"""
//val PUZZLE_INPUT = getFile()

fun getFile(): String {
    val filePath = "/Users/OKENNED3/code-personal/aoc/src/day3/input.txt"
    val file = File(filePath)

    val fileContent = file.readText()

    return fileContent
}
