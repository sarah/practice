class Greppr
  attr_accessor :filename, :pattern

  def initialize(filename,pattern)
    @filename= filename
    @pattern = pattern
  end
  
  def spit
    line_num = 0
    File.open(filename, "r") do |f|
      while(line = f.gets)
        puts "#{line_num}: #{line}" if line.match(pattern)  
        line_num = line_num + 1
      end
    end
  end
end


gr = Greppr.new("index.html", "img")
gr.spit
