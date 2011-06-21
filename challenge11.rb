# Challenge 11: Gas stations - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge11.rb

def gas_stations(k, d)
  i=1
  v=0
  stations=""

  while i < d.size do
    if d[i] <= d[v]+k then
      i+=1
    else
      v=i-1
      stations+="#{d[v]} "
    end
  end

  if v>0 then
    return stations[0..-2]
  else
    return "No stops"
  end
end

readline.strip.to_i.times do
  k = readline.strip.to_i
  df = readline.strip.to_i
  n = readline.strip.to_i
  d = readline.strip.split.map { |x| x.to_i }
  d = [0] + d + [df]
  puts gas_stations(k, d)
end
