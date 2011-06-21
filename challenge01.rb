# Challenge 1: Super hard sum - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge01.rb
# Comments: Ruby has arbitrary-precision arithmetic.

STDIN.each_line {|line| p line.split.map {|x| x.to_i }.inject(0, :+) }
