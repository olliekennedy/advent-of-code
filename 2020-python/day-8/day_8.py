import copy


def main():
    operation_list = get_operations_from_file_input()

    part_1_answer = part_1(operation_list)
    print('part_1_answer = ' + str(part_1_answer))
    assert part_1_answer == 1939

    part_2_answer = part_2(operation_list)
    print('part_2_answer = ' + str(part_2_answer))
    assert part_2_answer == 2212


def part_1(operation_list):
    _, accumulator = run_program(operation_list)
    return accumulator


def part_2(operation_list):
    for i in range(0, len(operation_list)):
        if operation_list[i][0] == 'acc':
            continue
        test_operation_list = swap_nop_and_jmp_at_position(i, operation_list)

        not_infinite, accumulator = run_program(test_operation_list)

        if not_infinite:
            return accumulator


def run_program(operation_list):
    seen_positions = []
    accumulator = 0
    position = 0
    while True:
        if position == len(operation_list):
            return True, accumulator

        if position in seen_positions:
            return False, accumulator

        seen_positions.append(position)

        operation, value = operation_list[position]
        match operation:
            case 'nop':
                position += 1
            case 'acc':
                position += 1
                accumulator += value
            case 'jmp':
                position += value


def swap_nop_and_jmp_at_position(i, operation_list):
    test_operation_list = copy.deepcopy(operation_list)
    test_operation_list[i][0] = 'jmp' if test_operation_list[i][0] == 'nop' else 'nop'
    return test_operation_list


def get_operations_from_file_input():
    file_input = open('input.txt').read().split('\n')
    operation_list = []
    for line in file_input:
        operation = line[:3]
        value = int(line[4:])
        operation_list.append([operation, value])
    return operation_list


if __name__ == '__main__':
    main()
