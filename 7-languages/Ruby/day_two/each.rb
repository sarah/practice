arr = []
16.times do |i|
  arr.push(i)
end
puts "\n\nUsing array: #{arr.join(" ")}\n\n"
puts "Using a custom .each"
arr.each do |item|
  slice_size  = 4
  slice_range = slice_size-1
  index = arr.index(item)
  if(arr.index(item)+1)%slice_size==0
    puts arr[(index-slice_range)..index].join("\t")
  end
end

puts "\n\nUsing .each_slice: "
arr.each_slice(4){|a| puts a.join("\t")}
puts "\n\n"
