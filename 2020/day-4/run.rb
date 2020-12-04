input = File.read('./input.txt').split("\n\n").map{ |x| x.gsub("\n", " ") }.map{ |x| x.split(" ") }#.map(&:to_i)
#puts input.inspect

count = 0
input.each do |x|
  byr = false
  iyr = false
  eyr = false
  hgt = false
  hcl = false
  ecl = false
  pid = false
  cid = false
  x.each do |y|
    if y.slice(0,3) == 'byr' && y.slice(4,20).length == 4 && y.slice(4,4).to_i <= 2002
      byr = true
    elsif y.slice(0,3) == 'iyr' && y.slice(4,20).length == 4 && y.slice(4,4).to_i.between?(2010,2020)
      iyr = true
    elsif y.slice(0,3) == 'eyr' && y.slice(4,20).length == 4 && y.slice(4,4).to_i.between?(2020,2030)
      eyr = true
    elsif y.slice(0,3) == 'hgt' && ['cm','in'].include?(y.slice(-2,2))
      if y.slice(-2,2) == 'cm'
        hgt = true if y.slice(4,3).to_i.between?(150,193)
      else
        hgt = true if y.slice(4,2).to_i.between?(59,76)
      end
    elsif y.slice(0,3) == 'hcl'
      if y[4] == '#' && y.slice(5,20).length == 6
        hcl = true
        y.slice(5,6).split("").each do |z|
          hcl = false if !['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'].include?(z)
        end
      end
    elsif y.slice(0,3) == 'ecl'
      ecl = true if ['amb','blu','brn','gry','grn','hzl','oth'].include?(y.slice(4,20))
    elsif y.slice(0,3) == 'pid'
      pid = true if y.slice(4,20).length == 9 && /\A\d+\z/.match(y.slice(4,20))
    elsif y.slice(0,3) == 'cid'
      cid = true
    end
  end
  count += 1 if byr == true && iyr == true && eyr == true && hgt == true && ecl == true && pid == true && hcl == true
end

puts count
