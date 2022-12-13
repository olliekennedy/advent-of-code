TEST = True


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

    hits = set()

    for x in range(-400, 400):
        print(x)
        for y in range(-400, 400):
            if sum_to_zero(x) < min_x:
                # print("won't reach")
                x += 1
                continue
            hit, spot = does_it_hit([x, y], min_x, max_x, min_y, max_y)
            # print(x, y, hit, spot, last_x)
            if hit:
                hits.add((x, y))

    print(hits)
    print(len(hits))
    print(sum_to_zero(max(map(lambda x: x[1], hits))))
    assert len(hits) == 112 if TEST else len(hits) == 1117


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
