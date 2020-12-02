class PasswordChecker
  def check(input)
    valid = 0
    sanitise(input).each do |ln|
      count = 0
      ln[:p].each { |p_c| count += 1 if p_c == ln[:c] }
      valid += 1 if count.between?(ln[:l], ln[:h])
    end
    return valid
  end

  def check2(input)
    valid = 0
    sanitise(input).each do |ln|
      count = 0
      count += 1 if ln[:c] == ln[:p][ln[:l] - 1]
      count += 1 if ln[:c] == ln[:p][ln[:h] - 1]
      valid += 1 if count == 1
    end
    return valid
  end

  def sanitise(input)
    input.map { |x|
      x.gsub("\n", "").split(" ")
    }.map { |x| {
      l: x[0].split("-").map(&:to_i)[0],
      h: x[0].split("-").map(&:to_i)[1],
      c: x[1].gsub(":", ""),
      p: x[2].split("")
    } }
  end
end
