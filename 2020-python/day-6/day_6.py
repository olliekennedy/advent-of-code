def main() -> None:
    lines = open('input.txt').read().split('\n\n')
    part_1_answer = part_1(lines)
    print('part_1_answer = ' + str(part_1_answer))
    assert part_1_answer == 6297

    part_2_answer = part_2(lines)
    print('part_2_answer = ' + str(part_2_answer))
    assert part_2_answer == 3158


def part_1(lines) -> int:
    count = 0
    for line in lines:
        count += len(set([char for char in line.replace('\n', '')]))
    return count


def part_2(lines) -> int:
    groups = groups_of_peoples_answers(lines)
    print(groups)
    total = 0
    for group in groups:
        total += common_answers_in(group)
    return total


def common_answers_in(group) -> int:
    common_answers = set(group[0])
    for person in group[1:]:
        common_answers.intersection_update(person)
    return len(common_answers)


def groups_of_peoples_answers(lines) -> list[list[list[str]]]:
    groups = []
    for line in lines:
        group = line.split('\n')
        people = []
        for person in group:
            questions_answered_yes = [question_answered_yes for question_answered_yes in person]
            people.append(questions_answered_yes)
        groups.append(people)
    return groups


if __name__ == '__main__':
    main()
