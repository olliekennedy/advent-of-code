package year2024.day13


fun main() {
    println("Test:")
    compute(TEST_INPUT)
    computePart2(TEST_INPUT)
//    println("Puzzle:")
//    compute(PUZZLE_INPUT)
}

const val A_COST = 3
const val B_COST = 1



private fun compute(input: String) {
    val instructions = getInstructionsFrom(input, true)

    val total = instructions.sumOf { it.calculateFewestTokens() }

    println(instructions[0])

    println("Part 1: $total")
}

// n1 = (targetX*y2 - targetY*x2) / (x1*y2 - y1*x2)
// n2 = (targetY*x1 - targetX*y1) / (x1*y2 - y1*x2)
private fun computePart2(input: String) {

    val instructions = getInstructionsFrom(input, false)

    val sums = mutableListOf<Long>()
    instructions.map { instruction ->
        sums.add(instruction.calculateFewestTokens())
    }

    println(instructions[0])

    println("Part 1: ${sums.sum()}")
}

fun Instruction.calculateFewestTokens(): Long {

    val validButtonCombinations = mutableSetOf<Pair<Long, Long>>()

    var numberOfBs = 0L
    while (numberOfBs * buttonB.movementX < prize.coordX) {
        tryThisNumberOfBsAndSeeIfSomeNumberOfAsCanMakeItToThePrize(numberOfBs)
            ?.let { validButtonCombinations.add(it) }

        numberOfBs += 1
    }

    val fewestTokens = validButtonCombinations.minOfOrNull { it.first * A_COST + it.second * B_COST } ?: 0L

    return fewestTokens
}

private fun Instruction.tryThisNumberOfBsAndSeeIfSomeNumberOfAsCanMakeItToThePrize(numberOfBs: Long): Pair<Long, Long>? {
    val howFarTheBsGetUsX = numberOfBs * buttonB.movementX
    val distanceTheAsNeedToCover = prize.coordX - howFarTheBsGetUsX
    val weCanGetExactlyToX = distanceTheAsNeedToCover % buttonA.movementX == 0L
    if (weCanGetExactlyToX) {
        val numberOfAs = distanceTheAsNeedToCover / buttonA.movementX
        val howFarTheAsGetUsY = buttonA.movementY * numberOfAs
        val howFarTheBsGetUsY = buttonB.movementY * numberOfBs
        val weCanGetExactlyToY = howFarTheAsGetUsY + howFarTheBsGetUsY == prize.coordY
        if (weCanGetExactlyToY) {
            return numberOfAs to numberOfBs
        }
    }
    return null
}

private fun getInstructionsFrom(input: String, isPart2: Boolean) = input.split("\n\n").map {
    val replace = it.split("\n")[0].replace("Button A: X+", "")
    val buttonAX = replace.slice(0..<replace.indexOf(",")).toLong()
    val buttonAY = replace.slice(replace.indexOf("+") + 1..<replace.length).toLong()
    val buttonA = Movement(movementX = if (isPart2) buttonAX * 10000000000000 else buttonAX, movementY = if (isPart2) buttonAY * 10000000000000 else buttonAY)
    val repla = it.split("\n")[1].replace("Button B: X+", "")
    val buttonBX = repla.slice(0..<repla.indexOf(",")).toLong()
    val buttonBY = repla.slice(repla.indexOf("+") + 1..<repla.length).toLong()
    val buttonB = Movement(movementX = if (isPart2) buttonBX * 10000000000000 else buttonBX, movementY = if (isPart2) buttonBY * 10000000000000 else buttonBY)
    val repl = it.split("\n")[2].replace("Prize: X=", "")
    val prizeX = repl.slice(0..<repl.indexOf(",")).toLong()
    val prizeY = repl.slice(repl.indexOf("=") + 1..<repl.length).toLong()
    val prize = Coordinate(coordX = if (isPart2) prizeX * 10000000000000 else prizeX, coordY = if (isPart2) prizeY * 10000000000000 else prizeY)
    Instruction(buttonA = buttonA, buttonB = buttonB, prize = prize)
}

data class Instruction(
    val buttonA: Movement,
    val buttonB: Movement,
    val prize: Coordinate,
)

data class Movement(
    val movementX: Long,
    val movementY: Long,
)

data class Coordinate(
    val coordX: Long,
    val coordY: Long,
)

fun checkSolvable(instruction: Instruction): Boolean {
    val gcdX = gcd(instruction.buttonA.movementX, instruction.buttonB.movementX)
    val gcdY = gcd(instruction.buttonA.movementY, instruction.buttonB.movementY)
    return instruction.prize.coordX % gcdX == 0L && instruction.prize.coordY % gcdY == 0L
}

fun gcd(a: Long, b: Long): Long {
    var num1 = a
    var num2 = b
    while (num2 != 0L) {
        val temp = num2
        num2 = num1 % num2
        num1 = temp
    }
    return num1
}

//        val n1 = (instruction.prize.coordX * instruction.buttonB.movementY - instruction.prize.coordY * instruction.buttonB.movementX) % (instruction.buttonA.movementX * instruction.buttonB.movementY - instruction.buttonA.movementY * instruction.buttonB.movementX) == 0L
//        val n2 = (instruction.prize.coordY * instruction.buttonA.movementX - instruction.prize.coordX * instruction.buttonA.movementY) % (instruction.buttonA.movementX * instruction.buttonB.movementY - instruction.buttonA.movementY * instruction.buttonB.movementX) == 0L

//        println("Solvable: ${n1 && n2} for $instruction")

//        val solvable = checkSolvable(instruction)