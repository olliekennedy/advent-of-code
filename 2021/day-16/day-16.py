TEST = True
MAPPING = {
    '0': '0000',
    '1': '0001',
    '2': '0010',
    '3': '0011',
    '4': '0100',
    '5': '0101',
    '6': '0110',
    '7': '0111',
    '8': '1000',
    '9': '1001',
    'A': '1010',
    'B': '1011',
    'C': '1100',
    'D': '1101',
    'E': '1110',
    'F': '1111',
}


def read_file(filename):
    return open(filename).read()


def process_literal(binary_number):
    chunk_list = []
    i = 0
    for i in range(0, len(binary_number), 5):
        chunk_list.append(binary_number[i:i + 5])
        if binary_number[i] == '0':
            break

    result_bin = ''.join([chunk[1:] for chunk in chunk_list])
    result = dec_from_bin(result_bin)
    print('literal value:', result)
    remaining = binary_number[i+5:]
    return remaining


def main():
    one_answer = run('one.txt')
    print('one_answer:', one_answer)
    # assert one_answer == 2021
    two_answer = run('two.txt')
    print('two_answer:', two_answer)
    three_answer = run('three.txt')
    print('three_answer:', three_answer)


def process_total_length(binary_number):
    print('binary_number:', binary_number)
    binary_total_length = binary_number[0:15]
    print('binary_total_length:', binary_total_length)
    length_of_all_subpackets = dec_from_bin(binary_total_length)
    print('length_of_all_subpackets:', length_of_all_subpackets)

    subpacket = binary_number[15:15 + length_of_all_subpackets]
    process_subpacket(subpacket)
    remaining = binary_number[15+length_of_all_subpackets:]
    return remaining



def process_operator(binary_number):
    length_type_id = binary_number[0]
    print('binary number before length type id:', binary_number)
    print('length_type_id:', length_type_id)
    remaining = ''
    if length_type_id == '0':
        remaining = process_total_length(binary_number[1:])
    elif length_type_id == '1':
        remaining = process_subpacket(binary_number[1:], 3)
    else:
        print('wrong length type id')
    return remaining


def run(filename):
    hex_string = read_file(filename)
    binary_string = binary_string_from_hex_string(hex_string)
    return process_subpacket(binary_string)


def process_subpacket(binary_string, quantity=-1):
    if quantity == 0:
        print('finished processing the given number of subpackets')
        return binary_string
    if len(binary_string) < 11:
        print('subpacket too small:', binary_string)
        return
    packet_version_bin = binary_string[0:3]
    packet_version = dec_from_bin(packet_version_bin)
    type_id_bin = binary_string[3:6]
    type_id = dec_from_bin(type_id_bin)
    binary_number = binary_string[6:]
    print('binary_string:', binary_string)
    answer = 'placeholder'
    if type_id == 4:
        remaining = process_literal(binary_number)
    else:
        remaining = process_operator(binary_number)
    print([f'{name} = {value}' for name, value in locals().items()])
    if quantity == -1:
        new_quantity = quantity
    else:
        new_quantity = quantity - 1
    return process_subpacket(remaining, new_quantity)


def dec_from_bin(packet_version_bin) -> int:
    return int(packet_version_bin, 2)


def binary_string_from_hex_string(file_contents):
    return ''.join(MAPPING[char] for char in file_contents)


if __name__ == '__main__':
    main()
