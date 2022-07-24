def process_instructions(minimum, maximum, instructions):
    for instruction in instructions:
        if instruction == 'L' or instruction == 'F':
            maximum = ((((maximum - minimum) + 1) / 2) + minimum) - 1
        else:
            minimum = (((maximum - minimum) + 1) / 2) + minimum
    return int(minimum)


def find_empty_seat(seat_ids):
    for seat_id in range(min(seat_ids), max(seat_ids)):
        if seat_id - 1 in seat_ids and seat_id + 1 in seat_ids and seat_id not in seat_ids:
            return seat_id


def main():
    lines = open('input.txt').read().split('\n')
    find_row = find_column = process_instructions
    seat_ids = list(map(lambda line: (find_row(0, 127, (line[:7])) * 8) + find_column(0, 7, (line[7:])), lines))

    assert max(seat_ids) == 864
    assert find_empty_seat(seat_ids) == 739


if __name__ == '__main__':
    main()
