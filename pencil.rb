require "csv"

class Pencil
  attr_reader :pencil

  def initialize()
    puts ("hi")
    @pencil = 0
  end

end

newPencil = Pencil.new
puts newPencil.pencil

File.open('note.txt', 'w') do |f|
  f.puts 'hello, world!'
end
