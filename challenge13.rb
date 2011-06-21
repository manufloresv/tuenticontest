# Challenge 13: The other clock - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge13.rb
# Comments: Just maths! no loops nor recursion; complexity: O(1)

# returns number of times that the leds turns on after s seconds
def segments(s)
  deltaseg=[0,0,4,1,1,2,1,1,4,0] # delta segments of each digit
  deltasum=deltaseg.each_index.map {|i| deltaseg[0..i].inject(0, :+)} # sum from 0 to i
  
  # calc basic units
  # hh:mm:ss
  ss = s%60
  mm = s/60%60
  hh = s/(60*60)%24
  # h2,h1:m2,m1:s2,s1
  s2,s1 = ss/10, ss%10
  m2,m1 = mm/10, mm%10
  h2,h1 = hh/10, hh%10

  # calc how many times each display turns on after s seconds
  # I should explain this mathematical formula
  b0 = 6 + (deltasum[9]+1)*(s/10)    + deltasum[s1]
  b1 = 6 + (deltasum[5]+2)*(s/60)    + deltasum[s2]
  b2 = 6 + (deltasum[9]+1)*(s/600)   + deltasum[m1]
  b3 = 6 + (deltasum[5]+2)*(s/3600)  + deltasum[m2]
  b4 = 6 + (deltasum[9]+1)*(s/36000) + deltasum[h1]
  b5 = 6 +                           + deltasum[h2]

  # return the sum of blinks of each display
  return b0+b1+b2+b3+b4+b5
end

# support for full days, when the clock position is reset
def total_segments(s)
  day=86400
  if (s<day)
    return segments(s)
  else
    return segments(s%day) + (segments(day-1)-26)*(s/day)
  end
end

STDIN.each_line do |line|
  puts total_segments(line.to_i)
end
