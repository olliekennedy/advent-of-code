def read_file_to_some_data_structure():
    file_contents = open('test.txt').read().split('.\n')
    # print(file_contents)
    dictionary = {}
    for file_content in file_contents:
        container, contents = file_content.split(' bags contain ')
        dictionary[container] = contents

    return dictionary


def part_1(bag_mapping):
    print(bag_mapping)
    shiny_gold_count = 0
    seen_gold_containers = ['shiny gold']
    previous_count = 0
    for _ in range(4):
        for key_bag, contents in bag_mapping.items():
            if any([container in contents for container in seen_gold_containers]) and key_bag not in seen_gold_containers:
                seen_gold_containers.append(key_bag)
                shiny_gold_count += 1
        print(seen_gold_containers)
        print('immediate contents = ' + str(shiny_gold_count))
        if shiny_gold_count == previous_count:
            print('bags that eventually contain shiny gold = ' + str(shiny_gold_count))
            break
        previous_count = shiny_gold_count

    # for key_bag, contents in bag_mapping.items():
    #     if any([container in contents for container in seen_gold_containers]) and key_bag not in seen_gold_containers:
    #         seen_gold_containers.append(key_bag)
    #         shiny_gold_count += 1
    # print(seen_gold_containers)
    # print('immediate contents = ' + str(shiny_gold_count))

    # print('immediate contents + first layer = ' + str(shiny_gold_count))


def main():
    bag_mapping = read_file_to_some_data_structure()
    part_1(bag_mapping)


if __name__ == '__main__':
    main()
