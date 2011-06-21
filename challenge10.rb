# Challenge 10: Key Combos - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge10.rb
#
# "A key combo can be up to 100 keys... Who is going to use this, Emacs users!?"

keys={}

readline.strip.to_i.times do
  keys[readline.strip.split.sort] = readline.strip
end

readline.strip.to_i.times do
  puts keys[readline.strip.split.sort]
end
