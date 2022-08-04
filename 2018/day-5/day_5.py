TEST = False


def main():
    file_contents = open('test.txt' if TEST else 'input.txt').read()
    print(file_contents)
    test()

    while True:
        is_there_a_reaction = False
        i = 0
        while i <= len(file_contents) - 2:
            char1 = file_contents[i]
            char2 = file_contents[i + 1]
            if do_these_react(char1, char2):
                file_contents = file_contents[:i] + file_contents[i + 2:]
                is_there_a_reaction = True
            i += 1

        if not is_there_a_reaction:
            break

    part_1_answer = len(file_contents)
    print(part_1_answer)
    assert part_1_answer == 10 if TEST else part_1_answer == 11668


def test():
    assert not do_these_react('A', 'A')
    assert do_these_react('A', 'a')
    assert not do_these_react('a', 'a')


def do_these_react(char1, char2):
    return char1.lower() == char2.lower() and char1.islower() ^ char2.islower()


if __name__ == '__main__':
    main()
