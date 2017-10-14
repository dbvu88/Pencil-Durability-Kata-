class Pencil
  attr_reader :pointDurability, :length, :filePath

  def initialize(durability, length, path)
    @pointDurability = durability
    @length = length
    @filePath = path
    File.open(@filePath, 'w') do |f|
      f.print ''
    end
    
  end

  def write(input)
    # input = gets
    text = ""
    input.each_char do |chr|
      if chr == chr.upcase
        if @pointDurability >= 2 && !chr.chomp.strip.empty?
          @pointDurability -= 2
          text += chr
        else
          text += " "
        end
      else
        if @pointDurability >= 1 && !chr.chomp.strip.empty?
          @pointDurability -= 1
          text += chr
        else
          text += " "
        end
      end
    end

    File.open(@filePath, 'a') do |f|
      f.print text
    end
  end

end
