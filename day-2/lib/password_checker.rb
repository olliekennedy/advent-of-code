class PasswordChecker
  def check(input)
    valid = 0
    sanitise(input).each do |check|
      count = 0
      check[:pass].each { |pass_char| count += 1 if pass_char == check[:char] }
      valid += 1 if count.between?(check[:l], check[:h])
    end
    return valid
  end

  def check2(input)
    valid = 0
    sanitise(input).each do |check|
      count = 0
      count += 1 if check[:char] == check[:pass][check[:l] - 1]
      count += 1 if check[:char] == check[:pass][check[:h] - 1]
      valid += 1 if count == 1
    end
    return valid
  end

  def sanitise(input)
    input.map { |x|
      x.gsub("\n", "").split(" ")
    # }.map { |x| [x[0].split("-").map(&:to_i), x[1].gsub(":", ""), x[2].split("")] }
    }.map { |x| {
      l: x[0].split("-").map(&:to_i)[0],
      h: x[0].split("-").map(&:to_i)[1],
      char: x[1].gsub(":", ""),
      pass: x[2].split("")
    } }
  end
end
