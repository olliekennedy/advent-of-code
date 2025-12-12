package year2024.day9

import kotlin.time.measureTime


fun main() {
    println(measureTime { compute(PUZZLE_INPUT) })
    println(measureTime { computePart2(PUZZLE_INPUT) })
}

private fun compute(input: String) {

    val chars = input.split("").filter { it.isNotEmpty() }.map { it.toInt() }
//    println("chars")
//    println(chars)

    val emptySpaces = mutableListOf<Int>()
    var real = true
    var counter = 0
    for (i in chars.indices) {
        repeat(chars[i]) {
            if (!real) {
                emptySpaces.add(counter)
            }
            counter++
        }
        real = !real
    }
//    println("emptySpaces")
//    println(emptySpaces)

    val fileBlocks = createFileBlocksFrom(chars)
//    println("fileBlocks")
//    println(fileBlocks)

    for (i in fileBlocks.indices.reversed()) {
        val firstEmptySpace = emptySpaces.first()

        if (i < firstEmptySpace) break

        val elementToCheck = fileBlocks[i]
        if (elementToCheck != "." && i > firstEmptySpace) {
            fileBlocks[firstEmptySpace] = elementToCheck
            fileBlocks[i] = "."
            emptySpaces.removeFirst()
        }
    }

//    println("new fileBlocks")
//    println(fileBlocks)

    var sum = 0L
    for (i in fileBlocks.indices) {
        val id = fileBlocks[i]
        if (id == ".") break

        sum += (i * id.toInt())
    }


    println("Part 1: $sum")
}

private fun computePart2(input: String) {

    val chars = input.split("").filter { it.isNotEmpty() }.map { it.toInt() }

    val something = mutableMapOf<Int, IntRange>()
    val emptySpaces = mutableListOf<IntRange>()
    var currentIndex = 0
    for (i in chars.indices) {
        if (chars[i] <= 0) continue

        if (i % 2 == 0) {
            something[i / 2] = currentIndex..<(currentIndex + chars[i])
        } else {
            emptySpaces.add(currentIndex..<(currentIndex + chars[i]))
        }

        currentIndex += chars[i]
    }

    for (id in something.keys.reversed()) {
        val blockSize = something[id]!!.last - something[id]!!.first

        val spaceToFill = emptySpaces.firstOrNull {
            val emptySpaceSize = it.last - it.first
            emptySpaceSize >= blockSize && it.first <= something[id]!!.first
        } ?: continue

        something[id] = spaceToFill.first..(spaceToFill.first + blockSize)
        if (spaceToFill.last - spaceToFill.first == blockSize) {
            emptySpaces.remove(spaceToFill)
        } else {
            emptySpaces[emptySpaces.indexOf(spaceToFill)] = (spaceToFill.first + blockSize + 1)..spaceToFill.last
        }
        break
    }

    val listOfDots = createFileBlocksFrom(chars).map { "." }.toMutableList()

    for (id in something.keys) {
        for (i in something[id]!!) {
            listOfDots[i] = id.toString()
        }
    }

    var sumPart2 = 0L
    for (i in listOfDots.indices) {
        val id = listOfDots[i]
        if (id == ".") continue

        sumPart2 += (i * id.toLong())
    }

    println("Part 2: $sumPart2")
}

private fun createFileBlocksFrom(chars: List<Int>): MutableList<String> {
    val fileBlocks = mutableListOf<String>()

    for (i in chars.indices) {
        if (i % 2 == 0) {
            repeat(chars[i]) {
                fileBlocks.add((i / 2).toString())
            }
        } else {
            repeat(chars[i]) {
                fileBlocks.add(".")
            }
        }
    }
    return fileBlocks
}

private fun prettyPrint(twoDeeMap: List<List<String>>, part2AntinodeLocations: MutableSet<Pair<Int, Int>>) {
    for (y in twoDeeMap.indices) {
        for (x in twoDeeMap[0].indices) {
            val char = twoDeeMap[y][x]
            if (char != ".") {
                print(char)
            } else {
                if (x to y in part2AntinodeLocations) {
                    print("#")
                } else {
                    print(".")
                }
            }
        }
        println()
    }
}
