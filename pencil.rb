require "csv"

class Pencil
  attr_reader :pointDurability, :length

  def initialize(durability, length)
    @pointDurability = durability
    @length = length
    File.open('SheetOfPaper.txt', 'w') do |f|
      f.print ''
    end
    # @pencil = 0
  end

  def write(input)
    # input = gets
    text = ""
    input.each_char do |chr|
      if chr == chr.upcase
        if @pointDurability >= 2 && !chr.strip.empty?
          @pointDurability -= 2
          text += chr
        else
          text += " "
        end
      else
        if @pointDurability >= 1 && !chr.strip.empty?
          @pointDurability -= 1
          text += chr
        else
          text += " "
        end
      end
    end

    File.open('SheetOfPaper.txt', 'a') do |f|
      f.print text
    end
  end

end
