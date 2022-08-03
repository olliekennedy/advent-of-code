TEST = False


def sum_to_zero(x):
    total = 0
    this_x = x
    while this_x > 0:
        total += this_x
        this_x -= 1
    return total


def main():
    file_contents = open('test.txt' if TEST else 'input.txt').read()
    print(file_contents)
    target = file_contents.replace('target area: x=', '').replace(' y=', '').split(',')
    min_x, max_x, min_y, max_y = get_min_max_x_y(target)
    print(get_min_max_x_y(target))
    # tests(min_x, max_x, min_y, max_y)
    input_velocity = [6, 9]
    # if does_it_hit(input_velocity, min_x, max_x, min_y, max_y):
    #     print('HIT with:', input_velocity)
    # else:
    #     print('MISS with:', input_velocity)

    x = 1
    y = 1
    last_x = x
    hits = []
    iterations = 0
    while True:
        if iterations > 10000:
            break
        iterations += 1
        print(hits)
        if sum_to_zero(x) < min_x:
            print("won't reach")
            x += 1
            continue
        hit, spot = does_it_hit([x, y], min_x, max_x, min_y, max_y)
        print(x, y, hit, spot, last_x)
        if hit:
            print('WOOOOOOO')
            hits.append([x, y])

        if spot[0] > max_x or spot[1] < min_y - 40:
            x += 1
            y = 1
            continue
        if spot[0] <= max_x:
            y += 1
            continue
    print(sum_to_zero(max(map(lambda x: x[1], hits))))

def tests(min_x, max_x, min_y, max_y):
    assert does_it_hit([7, 2], min_x, max_x, min_y, max_y)[0]
    assert does_it_hit([6, 3], min_x, max_x, min_y, max_y)[0]
    assert does_it_hit([9, 0], min_x, max_x, min_y, max_y)[0]
    assert not does_it_hit([17, -4], min_x, max_x, min_y, max_y)[0]


def does_it_hit(starting_velocity, min_x, max_x, min_y, max_y):
    x, y = 0, 0
    x_velocity = starting_velocity[0]
    y_velocity = starting_velocity[1]
    while True:
        x += x_velocity
        y += y_velocity

        if x_velocity > 0:
            x_velocity -= 1
        elif x_velocity < 0:
            x_velocity += 1
        y_velocity -= 1

        if min_x <= x <= max_x and min_y <= y <= max_y:
            return True, [x, y]
        if x > max_x or y < min_y:
            return False, [x, y]


def get_min_max_x_y(target):
    min_x, max_x = list(map(int, target[0].split('..')))
    min_y, max_y = list(map(int, target[1].split('..')))
    return min_x, max_x, min_y, max_y


if __name__ == '__main__':
    main()