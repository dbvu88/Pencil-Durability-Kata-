require_relative "../pencil"

RSpec.describe Pencil do

path = "SheetOfPaperTest.txt"
File.open(path, 'w') do |f|
  f.print ""
end
myPencil = Pencil.new(25, 100, 10, path)
  describe '#initialize' do
    context 'when creating a new pencil' do
      it 'returns a new pecil with given point durability' do
        expect(myPencil.pointDurability).to eq 25
      end
      it 'returns a new pecil with given point durability' do
        expect(myPencil.length).to eq 10
      end
      it 'returns a new pecil with given eraser durability' do
        expect(myPencil.eraserDurability).to eq 100
      end
      it 'returns a blank file' do
        expect(File.read(path).strip).to eq ""
      end
      it "raises error when file not found" do
        expect{raise Pencil.new(10, 100, 2,"")}.to raise_error(MissingFilePathError)
      end
    end
  end

  describe '#write' do
    context 'when writing text to the SheetOfPaper.txt file with the pencil' do
      it 'degrades the point durability' do
        myPencil.write("Hi")
        expect(myPencil.pointDegradation).to eq 3
        myPencil.write(" I am a blank piece of paper")
        expect(myPencil.pointDegradation).to eq 25
        myPencil.write(" Good Bye ")
        expect(myPencil.pointDegradation).to eq 25
        expect(File.read(path).size).to eq 40
      end
      it 'returns a letter in exchange of point durability' do
        expect(File.read(path)).to eql "Hi I am a blank piece of paper          "
      end
    end
  end

  describe '#sharpen' do
    context 'when point degradation is zero' do
      it 'reset the point degradation' do
        myPencil.sharpen
        expect(myPencil.pointDegradation).to eq 0
        expect(myPencil.length).to eq 9
      end
    end
    context 'when point degradation is not zero' do
      it 'does not reset the point degradation' do
        myPencil.write("After sharpening")
        myPencil.sharpen
        expect(myPencil.pointDegradation).to eq 16
      end
    end
  end

  describe '#erase' do
    context 'when promting the pencil to erase text that not included in the file' do
      it 'raises TextNotFoundError' do
        expect{ raise myPencil.erase "Physician"}.to raise_error(TextNotFoundError)
      end
    end

    context 'when asking to erase text from the file' do
      it 'replaces text with whitespace and decreases eraserDurability' do
        myPencil.erase("blank")
        expect(File.read(path)).to eq "Hi I am a       piece of paper          After sharpening"
        expect{ raise myPencil.erase("hi")}.to raise_error(TextNotFoundError)
        myPencil.erase("Hi")
        expect(File.read(path)).to eq "   I am a       piece of paper          After sharpening"
        myPencil.erase("sharpening")
        expect(File.read(path)).to eq "   I am a       piece of paper          After           "

        myPencil.erase("e")
        expect(File.read(path)).to eq "   I am a       piece of paper          Aft r           "
        myPencil.erase("e")
        expect(File.read(path)).to eq "   I am a       piece of pap r          Aft r           "
        myPencil.write(" I am ready")
        expect(File.read(path)).to eq "   I am a       piece of pap r          Aft r            I am ready"
        myPencil.sharpen
        expect(myPencil.pointDegradation).to eq 0
        expect(myPencil.length).to eq 8
        expect(myPencil.eraserDurability).to eq 81

        myPencil.erase("I am  ")
        expect(File.read(path)).to eq "   I am a       piece of pap r          Aft r                 ready"
        expect(myPencil.eraserDurability).to eq 78
        expect(myPencil.indexErased).to eq [10,0,46,14,7,50]
      end
    end


  end



end
