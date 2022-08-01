def read_file_to_some_data_structure():
    file_contents = open('input.txt').read().split('.\n')
    dictionary = {}
    for file_content in file_contents:
        container, contents = file_content.split(' bags contain ')
        dictionary[container] = contents

    return dictionary


def part_1(bag_mapping):
    validated_bags = ['shiny gold']
    while True:
        previous_validated_bags = validated_bags.copy()
        validated_bags = check_bags(bag_mapping, validated_bags)
        if len(previous_validated_bags) == len(validated_bags):
            print("No new containers")
            break
    validated_bags.remove('shiny gold')
    return len(validated_bags)


def check_bags(bag_mapping, seen_gold_containers):
    for key_bag, contents in bag_mapping.items():
        if any([container in contents for container in seen_gold_containers]) and key_bag not in seen_gold_containers:
            seen_gold_containers.append(key_bag)
    return seen_gold_containers


def main():
    bag_mapping = read_file_to_some_data_structure()
    part_1_answer = part_1(bag_mapping)
    print(part_1_answer)
    assert part_1_answer == 101


if __name__ == '__main__':
    main()
