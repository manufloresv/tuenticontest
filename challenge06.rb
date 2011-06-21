# Challenge 6: The clock - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge06.rb
# Comments: Just maths! no loops nor recursion; complexity: O(1)

# returns number of times that the leds turns on after s seconds
def segments(s)
  seg=[6,2,5,5,4,5,6,3,7,6] # segments of each digit
  sum=seg.each_index.map {|i| seg[0..i].inject(0, :+)} # sum of segments from 0 to i
  sum+=[0]
  
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
  b0 = sum[9]     *(s/10)    + sum[s1]
  b1 = sum[5]*10  *(s/60)    + sum[s2-1]*10    + seg[s2]*(              s1+1)
  b2 = sum[9]*60  *(s/600)   + sum[m1-1]*60    + seg[m1]*(              ss+1)
  b3 = sum[5]*600 *(s/3600)  + sum[m2-1]*600   + seg[m2]*(        m1*60+ss+1)
  b4 = sum[9]*3600*(s/36000) + sum[h1-1]*3600  + seg[h1]*(        mm*60+ss+1)
  b5 =                         sum[h2-1]*36000 + seg[h2]*(h1*3600+mm*60+ss+1)

  # return the sum of blinks of each display
  return b0+b1+b2+b3+b4+b5
end

# support for full days, when the clock position is reset
def total_segments(s)
  day=86400
  if (s<day)
    return segments(s)
  else
    return segments(s%day) + segments(day-1)*(s/day)
  end
end

STDIN.each_line do |line|
  puts total_segments(line.to_i)
end
