input = File.read("./input.txt").split("\n\n").map{ |x| x.gsub("\n", " ") }.map{ |x| x.split(" ") }#.map(&:to_i)
#puts input.inspect
hashes = []
input.each do |x|
  hash = {}
  x.each do |y|
    hash[y.slice(0,3)] = "#{y.slice(4,20)}"
  end
  hashes << hash
end

count = 0
hashes.each do |x|
  byr = iyr = eyr = hgt = hcl = ecl = pid = cid = false
  byr = true if !x["byr"].nil? && x["byr"].length == 4 && x["byr"].to_i <= 2002
  iyr = true if !x["iyr"].nil? && x["iyr"].length == 4 && x["iyr"].to_i.between?(2010,2020)
  eyr = true if !x["eyr"].nil? && x["eyr"].length == 4 && x["eyr"].to_i.between?(2020,2030)
  ecl = true if ["amb","blu","brn","gry","grn","hzl","oth"].include?(x["ecl"])
  pid = true if !x["pid"].nil? && x["pid"].length == 9 && /\A\d+\z/.match(x["pid"])
  if !x["hgt"].nil? && ["cm","in"].include?(x["hgt"].slice(-2,2))
    if x["hgt"].slice(-2,2) == "cm"
      hgt = true if x["hgt"].slice(0,3).to_i.between?(150,193)
    else
      hgt = true if x["hgt"].slice(0,2).to_i.between?(59,76)
    end
  end
  if !x["hcl"].nil? && x["hcl"][0] == "#" && x["hcl"].length == 7
    hcl = true
    x["hcl"].slice(1,6).split("").each do |y|
      hcl = false if !["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"].include?(y)
    end
  end
  count += 1 if byr && iyr && eyr && hgt && ecl && pid && hcl
end

puts count
