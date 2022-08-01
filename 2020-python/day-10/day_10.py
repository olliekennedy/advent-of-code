import numpy


def main() -> None:
    adapters = read_file('input.txt')

    part_1_answer = part_1(adapters.copy())
    print('part_1_answer = ' + str(part_1_answer))
    assert part_1_answer == 2574
    part_2_answer = part_2(adapters.copy())
    print('part_2_answer = ' + str(part_2_answer))
    assert part_2_answer == 2644613988352


def read_file(filename) -> list[int]:
    adapters = list(map(int, open(filename).read().split('\n')))
    adapters += [max(adapters) + 3, 0]
    adapters.sort()
    return adapters


def part_1(adapters_left) -> int:
    differences = list(numpy.diff(adapters_left))
    return differences.count(1) * differences.count(3)


def part_2(adapters) -> int:
    candidate_adapters = find_candidate_adapters_for(adapters)
    return find_all_routes_from(0, candidate_adapters, {})


def find_candidate_adapters_for(adapters_left) -> dict[int, list[int]]:
    candidate_adapters = {}
    for adapter1 in adapters_left:
        for adapter2 in adapters_left:
            if 3 >= (adapter2 - adapter1) > 0:
                if adapter1 not in candidate_adapters:
                    candidate_adapters[adapter1] = []
                candidate_adapters[adapter1].append(adapter2)
    return candidate_adapters


def find_all_routes_from(original_adapter, candidate_adapters, number_of_routes_from) -> int:
    if original_adapter not in candidate_adapters:
        return 1
    count = 0
    for adapter in candidate_adapters[original_adapter]:
        if adapter not in number_of_routes_from:
            number_of_routes_from[adapter] = find_all_routes_from(adapter, candidate_adapters, number_of_routes_from)
        count += number_of_routes_from[adapter]

    return count


if __name__ == '__main__':
    main()
