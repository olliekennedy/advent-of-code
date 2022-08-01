TEST = True


def read_file(filename):
    return open(filename).read()


def process_literal(binary_number):
    chunk_list = []
    for i in range(0, len(binary_number), 5):
        chunk_list.append(binary_number[i:i + 5])
        if binary_number[i] == '0':
            break

    result_bin = ''.join([chunk[1:] for chunk in chunk_list])
    result = dec_from_bin(result_bin)
    print(result)
    return result


def main():
    one_answer = run('one.txt')
    print('one_answer:', one_answer)
    assert one_answer == 2021
    two_answer = run('two.txt')
    print('two_answer:', two_answer)


def process_total_length(binary_number):
    length_of_all_subpackets = dec_from_bin(binary_number[:15])
    print('length_of_all_subpackets:', length_of_all_subpackets)


def process_operator(binary_number):
    length_type_id = binary_number[0]
    print('length_type_id:', length_type_id)
    if length_type_id == '0':
        process_total_length(binary_number[1:])


def run(filename):
    hex_string = read_file(filename)
    binary_string = binary_string_from_hex_string(hex_string)
    packet_version_bin = binary_string[0:3]
    packet_version = dec_from_bin(packet_version_bin)
    type_id_bin = binary_string[3:6]
    type_id = dec_from_bin(type_id_bin)
    binary_number = binary_string[6:]
    answer = 'placeholder'
    if type_id == 4:
        answer = process_literal(binary_number)
    else:
        answer = process_operator(binary_number)
    print([f'{name} = {value}' for name, value in locals().items()])
    return answer


def dec_from_bin(packet_version_bin) -> int:
    return int(packet_version_bin, 2)


def binary_string_from_hex_string(file_contents):
    return bin(int(file_contents, 16))[2:].zfill(8)


if __name__ == '__main__':
    main()
