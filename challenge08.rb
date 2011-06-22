# Challenge 8: The Biologist Problem - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge08.rb

def longest_seq(dna1, dna2, index1=0, index2=0, match="")
  longest=match
  "ctag".each_char do |x|
    i1 = dna1.index(match+x, index1)
    if i1
      i2 = dna2.index(match+x, index2)
      if i2
        xlongest = longest_seq(dna1, dna2, i1, i2, match+x)
        longest = xlongest if xlongest.size > longest.size
      end
    end
  end
  return longest
end

STDIN.each_line do |line|
  dna1, dna2 = line.split
  puts longest_seq(dna1, dna2)
end
