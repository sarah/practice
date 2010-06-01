class CsvRow
  def initialize(headers, items)
    @headers,@items = headers, items
  end
  def method_missing name, *args
    index = @headers.index name.to_s
    index ? @items[index] : "There is no column titled #{name}"
  end
end
module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  module InstanceMethods
    attr_accessor :headers, :csv_contents
    def initialize
      read
    end
    def each
      csv_contents.each {|row| yield CsvRow.new(@headers, row)}
    end
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + ".txt"
      file = File.new(filename)
      @headers = file.gets.chomp.split(", ")

      file.each do |row|
        @csv_contents << row.chomp.split(", ")
      end
    end
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end


csv = RubyCsv.new
csv.each{|row| puts row.one}
