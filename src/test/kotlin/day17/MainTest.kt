package day17

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments.arguments
import org.junit.jupiter.params.provider.MethodSource
import year2024.day17.advInstruction
import year2024.day17.bst
import year2024.day17.bxc
import year2024.day17.bxl
import year2024.day17.compute
import year2024.day17.computePart2
import year2024.day17.jnz
import year2024.day17.outInstruction


class MainTest {

    @Test
    fun `simple program to test adv and out`() {
        val input = """Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(4)))
    }

    @Test
    fun `test bdv and out`() {
        val input = """Register A: 729
Register B: 0
Register C: 0

Program: 6,1,5,5"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(4)))
    }

    @Test
    fun `test cdv and out`() {
        val input = """Register A: 729
Register B: 0
Register C: 0

Program: 7,1,5,6"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(4)))
    }

    @Test
    fun `another simple program`() {
        val input = """Register A: 10
Register B: 5
Register C: 6

Program: 5,0,5,1,5,2,5,3,5,4,5,5,5,6"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(0, 1, 2, 3, 2, 5, 6)))
    }

    @Test
    fun `a more complicated program`() {
        val input = """Register A: 2024
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(4, 2, 5, 6, 7, 7, 7, 7, 3, 1, 0)))
    }

    @Test
    fun `a program to test bst`() {
        val input = """Register A: 0
Register B: 0
Register C: 9

Program: 2,6,5,5"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(1)))
    }

    @Test
    fun `a program to test bxl`() {
        val input = """Register A: 0
Register B: 29
Register C: 0

Program: 1,7,5,5"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(2)))
    }

    @Test
    fun `a program to test something else`() {
        val input = """Register A: 0
Register B: 2024
Register C: 43690

Program: 4,0,5,5"""

        val result = compute(input)

        assertThat(result, equalTo(listOf(2)))
    }

    @Test
    fun `the official example program`() {
        val input = """Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0"""
        val result = compute(input)

        assertThat(result, equalTo(listOf(4, 6, 3, 5, 6, 3, 5, 2, 1, 0)))
    }

    @Test
    fun `bxc test`() {
        val regB = 2024
        val regC = 43690

        val result = bxc(regB, regC)

        assertThat(result, equalTo(44354))
    }

    @Test
    fun `bxl test`() {
        val regB = 29
        val operand = 7

        val result = bxl(regB, operand)

        assertThat(result, equalTo(26))
    }

    @Test
    fun `bst test`() {
        val comboOperand = 9

        val result = bst(comboOperand)

        assertThat(result, equalTo(1))
    }

    @Test
    fun `out test`() {
        val result = outInstruction(364)

        assertThat(result, equalTo(4))
    }

    @ParameterizedTest
    @MethodSource
    fun `jzn test`(instructionPointer: Int, regA: Int, operand: Int, expected: Int) {

        val result = jnz(instructionPointer, regA, operand)

        assertThat(result, equalTo(expected))
    }

    @ParameterizedTest
    @MethodSource
    fun `adv test`(regA: Int, operand: Int, expected: Int) {
        val result = advInstruction(regA, operand)

        assertThat(result, equalTo(expected))
    }

    @Test
    fun `part 2`() {
        val input = """Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0"""

        val result = computePart2(input)

        assertThat(result, equalTo(117440))
    }

    companion object {
        @JvmStatic
        fun `adv test`() =
            listOf(
                arguments(729, 1, 364),
                arguments(729, 2, 182),
                arguments(729, 3, 91),
            )

        @JvmStatic
        fun `jzn test`() =
            listOf(
                arguments(10, 0, 0, 12),
                arguments(10, 666, 0, 0),
                arguments(10, 666, 6, 6),
            )

    }
}