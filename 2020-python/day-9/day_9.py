TEST = False
PREAMBLE_LENGTH = 5 if TEST else 25


def part_1(numbers):
    for index, number in enumerate(numbers):
        if index < PREAMBLE_LENGTH:
            continue

        if not an_additive_pair_in(index, numbers, number):
            return number


def part_2(numbers, target_number):
    range_of_length_numbers = range(len(numbers))
    for i in range_of_length_numbers:
        for j in range_of_length_numbers:
            if j < i:
                continue
            sublist = numbers[i:j + 1]
            sum_of_sublist = sum(sublist)
            if sum_of_sublist > target_number:
                break

            if sum_of_sublist == target_number:
                return min(sublist) + max(sublist)


def main():
    numbers = list(map(int, open('test.txt' if TEST else 'input.txt').read().split('\n')))

    part_1_answer = part_1(numbers)
    print('part 1 answer = ' + str(part_1_answer))
    assert part_1_answer == 127 if TEST else part_1_answer == 258585477

    part_2_answer = part_2(numbers, part_1_answer)
    print('part 2 answer = ' + str(part_2_answer))
    assert part_2_answer == 62 if TEST else part_2_answer == 36981213


def an_additive_pair_in(k, numbers, number):
    for i, preamble1 in enumerate(numbers[k - PREAMBLE_LENGTH:k]):
        for j, preamble2 in enumerate(numbers[k - PREAMBLE_LENGTH:k]):
            if i == j:
                continue
            if preamble1 + preamble2 == number:
                return True
    return False


if __name__ == '__main__':
    main()
