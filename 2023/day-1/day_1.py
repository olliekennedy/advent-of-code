def main() -> None:
    lines = open('test.txt').read().split('\n')
    print(lines)

    example = lines[0]

    first = ''
    last = ''
    for i in range(len(example)):
        if example[i].isnumeric() and first == '':
            first = example[i]
            continue



word_to_digit_mapping = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
}


if __name__ == '__main__':
    main()
