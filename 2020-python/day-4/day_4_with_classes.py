VALID_EYE_COLOURS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
NUMERIC_CHARS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
COLOUR_CHARS = NUMERIC_CHARS + ['a', 'b', 'c', 'd', 'e', 'f']
REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']


class Passport:
    def __init__(self, attributes):
        self.attributes = attributes
        if self.has_required_fields():
            self.birth_year = int(self.attributes['byr'])
            self.issue_year = int(self.attributes['iyr'])
            self.expiration_year = int(self.attributes['eyr'])
            self.height = self.attributes['hgt']
            self.hair_colour = self.attributes['hcl']
            self.eye_colour = self.attributes['ecl']
            self.passport_id = self.attributes['pid']

    def valid_birth_year(self) -> bool:
        return 1920 <= self.birth_year <= 2002

    def valid_issue_year(self) -> bool:
        return 2010 <= self.issue_year <= 2020

    def valid_expiration_year(self) -> bool:
        return 2020 <= self.expiration_year <= 2030

    def valid_height(self) -> bool:
        if 'cm' in self.height:
            height_value = int(self.height.replace('cm', ''))
            if not 150 <= height_value <= 193:
                return False
        elif 'in' in self.height:
            height_value = int(self.height.replace('in', ''))
            if not 59 <= height_value <= 76:
                return False
        else:
            return False
        return True

    def valid_hair_colour(self) -> bool:
        if self.hair_colour[0] != '#' or self.hair_colour.count('#') != 1:
            return False

        colour_value = self.hair_colour[1:]
        if len(colour_value) != 6:
            return False

        for char in colour_value:
            if char not in COLOUR_CHARS:
                return False
        return True

    def valid_eye_colour(self) -> bool:
        return self.eye_colour in VALID_EYE_COLOURS

    def valid_passport_id(self) -> bool:
        if len(self.passport_id) != 9:
            return False

        for digit in self.passport_id:
            if digit not in NUMERIC_CHARS:
                return False
        return True

    def has_required_fields(self) -> bool:
        for required_field in REQUIRED_FIELDS:
            if required_field not in self.attributes:
                return False
        return True

    def all_fields_are_valid(self) -> bool:
        if not self.has_required_fields():
            return False

        if not all([
            self.valid_birth_year(),
            self.valid_issue_year(),
            self.valid_expiration_year(),
            self.valid_height(),
            self.valid_hair_colour(),
            self.valid_eye_colour(),
            self.valid_passport_id(),
        ]):
            return False
        return True


def get_passports_from(filename) -> list[Passport]:
    passports = []
    with open(filename) as f:
        sanitised_lines: list[list[str]] = list(map(lambda x: x.replace('\n', ' ').read_file_to_lines(' '), f.read().split('\n\n')))
        for line in sanitised_lines:
            passport_dict = {}
            for attribute in line:
                field, value = attribute.split(':')
                passport_dict[field] = value
            passport = Passport(passport_dict)
            if passport.has_required_fields():
                passports.append(passport)
    return passports


def part_1(passports) -> str:
    return str(len(passports))


def part_2(passports) -> str:
    return str(sum(passport.all_fields_are_valid() for passport in passports))


def main():
    passports = get_passports_from('input.txt')
    part_1_answer = part_1(passports)
    print('Answer to part 1 -> ' + part_1_answer)
    assert part_1_answer == '206'
    part_2_answer = part_2(passports)
    print('Answer to part 2 -> ' + part_2_answer)
    assert part_2_answer == '123'


if __name__ == '__main__':
    main()
