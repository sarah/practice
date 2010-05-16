
#!/usr/local/bin/ruby -w

require 'greppr'

puts "Give me a web page"
page = gets

puts "OK, now give me a phrase"
phrase = gets

puts "you said: #{page} and #{phrase}"

# 
# %x[wget #{page}]

gr = Greppr.new("index.html", "div")
gr.eat
