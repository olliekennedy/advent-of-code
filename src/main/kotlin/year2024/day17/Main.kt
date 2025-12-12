package year2024.day17

import kotlin.math.pow
import kotlin.math.truncate

fun main() {
//    println("Test:")
//    println(compute(TEST_INPUT)?.joinToString(","))
    println("Test Part 2:")
    println(computePart2(TEST_INPUT_2))
//    println("Puzzle:")
//    println(compute(PUZZLE_INPUT)?.joinToString(","))
    println("Puzzle Part 2:")
    println(computePart2(PUZZLE_INPUT))
}

fun compute(registers: Register, program: List<Int>, checking: Boolean = false): List<Int>? {
    val out = mutableListOf<Int>()

    var instructionPointer = 0
    while (instructionPointer < program.size) {
        val opcode = program[instructionPointer]
        val operand = program[instructionPointer + 1]

        when (opcode) {
            0 -> {
                registers.a = advInstruction(registers.a, operand.toCombo(registers))
            }
            1 -> {
                registers.b = bxl(registers.b, operand)
            }
            2 -> {
                registers.b = bst(operand.toCombo(registers))
            }
            3 -> {
                instructionPointer = jnz(instructionPointer, registers.a, operand)
            }
            4 -> {
                registers.b = bxc(registers.b, registers.c)
            }
            5 -> {
                val toOutput = outInstruction(operand.toCombo(registers))
                if (checking) {
                    if (out.size >= program.size || program[out.size] != toOutput) {
                        return null
                    }
                }
                out.add(toOutput)
            }
            6 -> {
                registers.b = bdvInstruction(registers, operand.toCombo(registers))
            }
            7 -> {
                registers.c = cdvInstruction(registers, operand.toCombo(registers))
            }
            else -> {
                TODO()
            }
        }

        when (opcode) {
            0,1,2,4,5,6,7 -> instructionPointer += 2
        }

    }

    if (checking) {
        return if (out == program) {
            mutableListOf(239448234)
        } else {
            null
        }
    }

    return out
}

fun computePart2(registers: Register, program: List<Int>): Boolean {
    val out = mutableListOf<Int>()

    var instructionPointer = 0
    while (instructionPointer < program.size) {
        val opcode = program[instructionPointer]
        val operand = program[instructionPointer + 1]

        when (opcode) {
            0 -> {
                registers.a = advInstruction(registers.a, operand.toCombo(registers))
                instructionPointer += 2
            }
            1 -> {
                registers.b = bxl(registers.b, operand)
                instructionPointer += 2
            }
            2 -> {
                registers.b = bst(operand.toCombo(registers))
                instructionPointer += 2
            }
            3 -> {
                instructionPointer = jnz(instructionPointer, registers.a, operand)
            }
            4 -> {
                registers.b = bxc(registers.b, registers.c)
                instructionPointer += 2
            }
            5 -> {
                outInstruction(operand.toCombo(registers))
                    .also { if (program[out.size] != it) return false }
                    .let { out.add(it) }
                instructionPointer += 2
            }
            6 -> {
                registers.b = bdvInstruction(registers, operand.toCombo(registers))
                instructionPointer += 2
            }
            7 -> {
                registers.c = cdvInstruction(registers, operand.toCombo(registers))
                instructionPointer += 2
            }
            else -> {
                TODO()
            }
        }
    }

    return out == program
}

fun computePart2(input: String): Long {
    val (regs, program) =
        input
            .split("\n\n")
            .let {
                it[0].split("\n").map { it.split(": ")[1].toInt() } to
                    it[1].split(": ")[1].split(",").map { it.toInt() }
            }

    val registers = Register(regs[0], regs[1], regs[2])

    for (i in 0..100000000000) {
        if (i % 1000000 == 0L) println("Checking A = $i")
        val result = computePart2(registers.apply { a = i.toInt() }, program)
        if (result) return i
    }
    return 666L
}

fun compute(input: String, checking: Boolean = false): List<Int>? {
    val (regs, program) =
        input
            .split("\n\n")
            .let {
                it[0].split("\n").map { it.split(": ")[1].toInt() } to
                    it[1].split(": ")[1].split(",").map { it.toInt() }
            }

    val registers = Register(regs[0], regs[1], regs[2])

    return compute(registers, program, checking)
}

private fun bdvInstruction(registers: Register, operand: Int): Int =
    advInstruction(registers.a, operand)

private fun cdvInstruction(registers: Register, operand: Int): Int =
    advInstruction(registers.a, operand)

private fun Int.toCombo(registers: Register): Int =
    when (this) {
        0, 1, 2, 3 -> this
        4 -> registers.a
        5 -> registers.b
        6 -> registers.c
        else -> TODO()
    }

fun advInstruction(regA: Int, operand: Int): Int {
    return truncate(regA / 2.0.pow(operand)).toInt()
}

fun bxl(regB: Int, operand: Int): Int {
    return regB xor operand
}

fun bst(comboOperand: Int): Int {
    return comboOperand % 8
}

fun jnz(instructionPointer: Int, regA: Int, operand: Int): Int =
    if (regA == 0) instructionPointer + 2 else operand

fun bxc(regB: Int, regC: Int): Int {
    return regB xor regC
}

fun outInstruction(operand: Int): Int {
    return operand % 8
}

data class Register(
    var a: Int,
    var b: Int,
    var c: Int,
)
