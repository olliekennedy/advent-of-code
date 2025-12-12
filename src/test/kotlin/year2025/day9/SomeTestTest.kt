package year2025.day9

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.example.lunchleague.day9.Position
import org.example.lunchleague.day9.checkIfAllPositionsAlongLineInsideGreenTiles
import org.example.lunchleague.day9.prettyPrint
import kotlin.test.Test

class SomeTestTest {
    @Test
    fun name() {
        val tiles = mutableListOf(Position(x=7, y=1), Position(x=11, y=1), Position(x=11, y=7), Position(x=9, y=7), Position(x=9, y=5), Position(x=2, y=5), Position(x=2, y=3), Position(x=7, y=3), Position(x=7, y=1))
        val greenTiles = mutableSetOf(Position(x = 7, y = 1), Position(x=8, y=1), Position(x=9, y=1), Position(x=10, y=1), Position(x=11, y=1), Position(x=11, y=2), Position(x=11, y=3), Position(x=11, y=4), Position(x=11, y=5), Position(x=11, y=6), Position(x=11, y=7), Position(x=9, y=7), Position(x=10, y=7), Position(x=9, y=5), Position(x=9, y=6), Position(x=2, y=5), Position(x=3, y=5), Position(x=4, y=5), Position(x=5, y=5), Position(x=6, y=5), Position(x=7, y=5), Position(x=8, y=5), Position(x=2, y=3), Position(x=2, y=4), Position(x=3, y=3), Position(x=4, y=3), Position(x=5, y=3), Position(x=6, y=3), Position(x=7, y=3), Position(x=7, y=2))

        prettyPrint(tiles, greenTiles)

        val result = checkIfAllPositionsAlongLineInsideGreenTiles(
            Position(x = 2, y = 3),
            Position(x = 4, y = 3),
            greenTiles,
        )

        assertThat(result, equalTo(true))
    }

    @Test
    fun `check a simple line across two boundaries`() {
        val tiles = mutableListOf(Position(x=7, y=1), Position(x=11, y=1), Position(x=11, y=7), Position(x=9, y=7), Position(x=9, y=5), Position(x=2, y=5), Position(x=2, y=3), Position(x=7, y=3), Position(x=7, y=1))
        val greenTiles = mutableSetOf(Position(x = 7, y = 1), Position(x=8, y=1), Position(x=9, y=1), Position(x=10, y=1), Position(x=11, y=1), Position(x=11, y=2), Position(x=11, y=3), Position(x=11, y=4), Position(x=11, y=5), Position(x=11, y=6), Position(x=11, y=7), Position(x=9, y=7), Position(x=10, y=7), Position(x=9, y=5), Position(x=9, y=6), Position(x=2, y=5), Position(x=3, y=5), Position(x=4, y=5), Position(x=5, y=5), Position(x=6, y=5), Position(x=7, y=5), Position(x=8, y=5), Position(x=2, y=3), Position(x=2, y=4), Position(x=3, y=3), Position(x=4, y=3), Position(x=5, y=3), Position(x=6, y=3), Position(x=7, y=3), Position(x=7, y=2))

        prettyPrint(tiles, greenTiles)

        val result = checkIfAllPositionsAlongLineInsideGreenTiles(
            Position(x = 7, y = 2),
            Position(x = 11, y = 2),
            greenTiles,
        )

        assertThat(result, equalTo(true))
    }
}