# Challenge 8: The Biologist Problem - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge08.rb

def longest_seq(dna1, dna2, match="")
  longest=match
  "ctag".each_char do |x|
    if dna1.include? match+x and dna2.include? match+x
      xlongest = longest_seq(dna1, dna2, match+x)
      longest = xlongest if xlongest.size > longest.size
    end
  end
  return longest
end

STDIN.each_line do |line|
  dna1, dna2 = line.split
  puts longest_seq(dna1, dna2)
end
