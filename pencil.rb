class MissingFilePathError < StandardError
end

class TextNotErasableError < StandardError
end

class TextNotFoundError < StandardError
end

class PencilNotUsable < StandardError
end

class EraserNotUsable < StandardError
end

class Pencil

  attr_reader :pointDurability, :length, :filePath, :pointDegradation, :eraserDurability, :writable, :erasable

  def initialize(durability, eraser, length, path)
    if path == nil || path.empty?
      raise MissingFilePathError
    end

    @eraserDurability = eraser

    @writable = true
    @erasable = true

    @pointDurability = durability
    @pointDegradation = 0
    @length = length
    @filePath = path

  end

  def write(input)
    if @length == 0
      raise PencilNotUsable
    end
    text = ""
    input.each_char do |chr|
      if chr != " "
        if chr == chr.upcase && @pointDegradation <= @pointDurability-2
          @pointDegradation += 2
          text += chr
        elsif chr != chr.upcase && @pointDegradation <= @pointDurability-1
          @pointDegradation += 1
          text += chr
        else
          text += " "
        end
      else
        text += " "
      end
    end

    File.open(@filePath, 'a') do |f|
      f.print text
    end
  end

  def sharpen
    if @length == 0
      raise PencilNotUsable
    end
    if @pointDegradation == @pointDurability
      @pointDegradation = 0
      @length -= 1
    else
      # puts "Your pencil is still sharp enough."
    end
  end


  def erase(input)
    input = input.strip

    if @eraserDurability == 0
      raise EraserNotUsable
    end

    text = ""

    File.open(@filePath, 'r') do |f|
      text = f.read
    end


    if input.size > text.size
      raise TextNotErasableError
    end

    if !text.include? input
      raise TextNotFoundError
    end

    indexLastOccurence = 0
    scannedTextTotal = ""
    scannedText = ""
    # initial unscannedText is the entire text from the file
    unscannedText = text
    # search for the last occurence of input in the text
    while unscannedText.include? input do
      # get the index of the first occurence
      i = unscannedText.index(input)
      
      # assign the scanned text & unscanned text to approriate varible
      scannedText = unscannedText[0...i+input.size]

      scannedTextTotal << scannedText
      unscannedText = unscannedText[i+input.size...text.size]
    end

    newText = scannedTextTotal[0, scannedTextTotal.size - input.size] << " " * input.size << unscannedText

    File.open(@filePath, 'w') do |f|
      f.print newText
    end
    @eraserDurability -= input.gsub(/\s/,"").split("").size
  end

  def edit(input)

    File.open(@filePath, 'r') do |f|
        text = f.read
    end

    text.index("   ")



  end

end
