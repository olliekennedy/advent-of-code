class PasswordChecker
  def check(input)
    valid = 0
    sanitise(input).each do |check|
      count = 0
      check[:p].each { |p_c| count += 1 if p_c == check[:c] }
      valid += 1 if count.between?(check[:l], check[:h])
    end
    return valid
  end

  def check2(input)
    valid = 0
    sanitise(input).each do |check|
      count = 0
      count += 1 if check[:c] == check[:p][check[:l] - 1]
      count += 1 if check[:c] == check[:p][check[:h] - 1]
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
      c: x[1].gsub(":", ""),
      p: x[2].split("")
    } }
  end
end
