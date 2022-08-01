TEST = True
NEIGHBOURS = [[-1, -1], [0, -1], [+1, -1],
              [-1,  0],          [+1,  0],
              [-1, +1], [0, +1], [+1, +1]]


def main():
    part_1_answer = run_part("part1")
    print('part_1_answer = ' + str(part_1_answer))
    assert part_1_answer == 37 if TEST else part_1_answer == 2424
    part_2_answer = run_part("part2")
    print('part_2_answer = ' + str(part_2_answer))
    assert part_2_answer == 26 if TEST else part_2_answer == 2208


def run_part(part) -> int:
    seat_layout = read_file('test.txt' if TEST else 'input.txt')
    occupied_seats, empty_seats = initial_occupied_and_empty_seats_from(seat_layout)
    width = len(seat_layout[0])
    height = len(seat_layout)
    while True:
        new_occupied_seats, new_empty_seats = set(), set()
        for y in range(height):
            for x in range(width):
                max_neighbours = 4 if part == 'part1' else 5
                seat = tuple([x, y])
                occupied_neighbour_count = count_occupied_neighbours(seat, empty_seats, occupied_seats, height, width,
                                                                     part)

                if seat in empty_seats and occupied_neighbour_count == 0:
                    new_occupied_seats.add(seat)
                    continue
                if seat in occupied_seats and occupied_neighbour_count >= max_neighbours:
                    new_empty_seats.add(seat)
                    continue

                if seat in empty_seats:
                    new_empty_seats.add(seat)
                elif seat in occupied_seats:
                    new_occupied_seats.add(seat)

        if nothing_has_changed(empty_seats, new_empty_seats, new_occupied_seats, occupied_seats):
            break
        occupied_seats = new_occupied_seats.copy()
        empty_seats = new_empty_seats.copy()

    # final_seat_layout = construct_seat_layout(occupied_seats, empty_seats, height, width)
    # print_nicely(final_seat_layout)
    return len(occupied_seats)


def read_file(filename) -> list[list[str]]:
    return list(map(lambda line: [char for char in line], open(filename).read().split('\n')))


def initial_occupied_and_empty_seats_from(seat_layout) -> tuple[set[tuple[int, ...]], set[tuple[int, ...]]]:
    occupied_seats = set()
    empty_seats = set()
    for y, line in enumerate(seat_layout):
        for x, seat in enumerate(line):
            if seat == '#':
                occupied_seats.add(tuple([x, y]))
            if seat == 'L':
                empty_seats.add(tuple([x, y]))

    return occupied_seats, empty_seats


def construct_seat_layout(occupied_seats, empty_seats, height, width) -> list[list[str]]:
    seat_layout = []
    for _ in range(height):
        seat_layout.append([])
    for y in range(height):
        for x in range(width):
            coordinates = tuple([x, y])
            if coordinates in occupied_seats:
                seat_layout[y].append('#')
            elif coordinates in empty_seats:
                seat_layout[y].append('L')
            else:
                seat_layout[y].append('.')
    return seat_layout


def flat_list_of(two_dimensional_list) -> list:
    return [x for y in two_dimensional_list for x in y]


def nothing_has_changed(empty_seats, new_empty_seats, new_occupied_seats, occupied_seats):
    return occupied_seats == new_occupied_seats and empty_seats == new_empty_seats


def count_occupied_neighbours(seat, empty_seats, occupied_seats, height, width, part):
    occupied_neighbour_count = 0
    for neighbour_diff in NEIGHBOURS:
        neighbour = get_next_neighbour(neighbour_diff, seat)
        while True:
            if out_of_bounds(neighbour, height, width) or neighbour in empty_seats:
                break

            if neighbour in occupied_seats:
                occupied_neighbour_count += 1
                break

            if part == 'part1':
                break
            elif part == 'part2':
                neighbour = get_next_neighbour(neighbour_diff, neighbour)

    return occupied_neighbour_count


def get_next_neighbour(neighbour_diff, seat):
    return tuple(sum(value) for value in zip(seat, neighbour_diff))


def out_of_bounds(neighbour_coord, height, width):
    return neighbour_coord[0] < 0 or neighbour_coord[0] > width or neighbour_coord[1] < 0 or neighbour_coord[1] > height


def print_nicely(seat_layout):
    for line in seat_layout:
        for char in line:
            print(char, end='  ')
        print()

    print('____________________________\n')


if __name__ == '__main__':
    main()
