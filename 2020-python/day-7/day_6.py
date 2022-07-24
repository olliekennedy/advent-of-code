def main() -> None:
    bags_mapping = extract_file_to_bags_mapping()

    part_1_answer = part_1(bags_mapping)
    print('part_1_answer = ' + str(part_1_answer))
    assert part_1_answer == 101

    part_2_answer = part_2('shiny gold', bags_mapping)
    print('part_2_answer = ' + str(part_2_answer))
    assert part_2_answer == 108636


def part_1(bags_mapping) -> int:
    shiny_gold_count = 0
    for original_bag in bags_mapping:
        if bag_search_1(original_bag, bags_mapping):
            shiny_gold_count += 1
    return shiny_gold_count


def part_2(original_bag, bags_mapping) -> int:
    # return zero bags if a bag contains no other bags
    if original_bag not in bags_mapping:
        return 0

    # for each sub-bag, see how many sub-bags it has, add one to include the sub-bag and multiply by the quantity
    bag_count = 0
    for sub_bag, quantity in bags_mapping[original_bag].items():
        bag_count += (part_2(sub_bag, bags_mapping) + 1) * quantity
    return bag_count


def bag_search_1(original_bag, bags_mapping) -> bool:
    # recursion exit 1
    if original_bag not in bags_mapping:
        return False

    # recursion exit 2
    if 'shiny gold' in list(bags_mapping[original_bag].keys()):
        return True

    # otherwise go deeper into the recursion...
    found = False
    for bag in bags_mapping[original_bag]:
        if bag_search_1(bag, bags_mapping):
            found = True

    # propagate a deeper recursion exit
    return found


def extract_file_to_bags_mapping() -> dict[str, dict[str, int]]:
    lines = open('input.txt').read().split('\n')

    contents_of_bag = {}
    for line in lines:
        if 'no other bags.' in line:
            continue

        original_bag, sub_bags_string = line.split(' bags contain ')

        to_delete = ' bags.', ' bag.', ' bags', ' bag'
        for string in to_delete:
            sub_bags_string = sub_bags_string.replace(string, '')

        sub_bags = {}
        for sub_bag in sub_bags_string.split(', '):
            sub_bags[sub_bag[2:]] = int(sub_bag[0])
        contents_of_bag[original_bag] = sub_bags

    return contents_of_bag


if __name__ == '__main__':
    main()
