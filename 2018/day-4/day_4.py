def main():
    file_contents = open('input.txt').read()
    print(file_contents)

    formatted_log = sorted_formatted_log(file_contents)
    guards_sleep_log = per_guard_sleep_log_from(formatted_log)
    guards_minute_log = convert_to_log_of_minutes_from(guards_sleep_log)
    guards_total_minutes = total_minutes_per_guard_from(guards_minute_log)

    part_1_answer = part_1(guards_minute_log, guards_total_minutes)
    print('part 1 answer:', part_1_answer)
    assert part_1_answer == 39698

    part_2_answer = part_2(guards_minute_log)
    print('part 2 answer:', part_2_answer)
    assert part_2_answer == 14920


def part_2(guards_minute_log):
    max_guard = ''
    max_minute = ''
    max_occurrences = 0
    for guard, minute_log in guards_minute_log.items():
        for minute, occurrences in minute_log.items():
            if occurrences > max_occurrences:
                max_guard = guard
                max_minute = minute
                max_occurrences = occurrences
    part_2_answer = int(max_guard) * max_minute
    return part_2_answer


def part_1(guards_minute_log, guards_total_minutes):
    sleepiest_guard = max(guards_total_minutes, key=guards_total_minutes.get)
    sleepiest_minute = max(guards_minute_log[sleepiest_guard], key=guards_minute_log[sleepiest_guard].get)
    part_1_answer = int(sleepiest_guard) * int(sleepiest_minute)
    return part_1_answer


def total_minutes_per_guard_from(guards_minute_log):
    guards_total_minutes = {}
    for guard, minute_log in guards_minute_log.items():
        guard_total = sum(minute_log.values())
        guards_total_minutes[guard] = guard_total
    print(guards_total_minutes)
    return guards_total_minutes


def convert_to_log_of_minutes_from(guards_sleep_log):
    guards_minute_log = {}
    for guard, sleep_times in guards_sleep_log.items():
        minute_log = {}
        for sleep_time in sleep_times:
            for minute in range(int(sleep_time[0][3]), int(sleep_time[1][3])):
                if minute not in minute_log:
                    minute_log[minute] = 1
                    continue
                minute_log[minute] += 1
        guards_minute_log[guard] = minute_log
    print(guards_minute_log)
    return guards_minute_log


def per_guard_sleep_log_from(formatted_log):
    guards_sleep_log = {}
    current_guard = ''
    for i in range(len(formatted_log)):
        log = formatted_log[i]
        if log[4].isnumeric():
            if log[4] not in guards_sleep_log:
                guards_sleep_log[log[4]] = []
            current_guard = log[4]
            continue
        if log[4] == 'asleep':
            guards_sleep_log[current_guard].append([log[0:4], formatted_log[i + 1][0:4]])
    print(guards_sleep_log)
    return guards_sleep_log


def sorted_formatted_log(file_contents):
    formatted_log = []
    for line in file_contents.split('\n'):
        formatted_line = line
        if 'Guard' in formatted_line:
            formatted_line = formatted_line.replace('] Guard #', ',').replace(' begins shift', '')
        if 'asleep' in formatted_line:
            formatted_line = formatted_line.replace('] falls asleep', ',asleep')
        if 'up' in formatted_line:
            formatted_line = formatted_line.replace('] wakes up', ',up')
        formatted_line = formatted_line.replace('[1518-', '').replace(' ', ',').replace('-', ',').replace(':', ',')
        formatted_log.append(formatted_line.split(','))
    formatted_log.sort()
    print(formatted_log)
    return formatted_log


if __name__ == '__main__':
    main()
