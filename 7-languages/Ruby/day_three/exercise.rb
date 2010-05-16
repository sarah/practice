class CsvRow
  attr_accessor :row, :header
  def initialize(row_content)
    @header = row_content.shift
    @row = row_content
  end
  def header
    @header
  end
  def method_missing name, *args
    method_name = name.to_s.downcase
    if method_name == header.to_s.downcase
      puts row
    end
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
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    attr_accessor :headers, :csv_contents

    def each(&block)
      @headers.each_with_index do |header, index|
        row_content = [header]
        @csv_contents.each do |arr|
          row_content << arr[index]
        end
        row = CsvRow.new(row_content) 
        yield row
      end
    end

    def initialize
      read
    end
  end
end


class RubyCsv 
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
csv.each{|row| puts row.dogs}
