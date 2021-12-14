input = "cwog og cwi 7cw ahigcoet: xiexui kent kicziit toticiit lencj gov stf toticiit govcj lehn sni yeppetuj dtezt sg kskj zwsc?"
answer = "boomers"
mapping = {
  "a" => "q",
  "b" => "_",
  "c" => "t",
  "d" => "k",
  "e" => "o",
  "f" => "d",
  "g" => "s",
  "h" => "u",
  "i" => "e",
  "j" => "y",
  "k" => "b",
  "l" => "f",
  "m" => "_",
  "n" => "r",
  "o" => "i",
  "p" => "m",
  "q" => "_",
  "r" => "_",
  "s" => "a",
  "t" => "n",
  "u" => "l",
  "v" => "x",
  "w" => "h",
  "x" => "p",
  "y" => "c",
  "z" => "w"
}

puts input.split("").map{ |x| x.match(/^[[:alpha:]]$/) ? mapping[x] : x }.join
print "Answer is: " unless answer.empty?
puts answer.split("").map { |x| mapping.key(x) }.join