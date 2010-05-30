class CsvRow
  attr_accessor :row, :header
  def initialize(header, row_content)
    @header = header
    @row = row_content
  end
  def method_missing name, *args
    puts row if name.to_s.downcase == header.to_s.downcase
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

      @csv_contents = file.map do |row|
        row.chomp.split(', ')
      end
    end

    attr_accessor :headers, :csv_contents

    def each(&block)
      @headers.each_with_index do |header, index|
        row_content = @csv_contents.map do |arr|
          arr[index]
        end
        yield CsvRow.new(header, row_content)
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
