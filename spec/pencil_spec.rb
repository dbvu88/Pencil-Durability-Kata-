require_relative "../pencil"

RSpec.describe Pencil do

path = "SheetOfPaper.txt"
myPencil = Pencil.new(25, 10, path)
  describe '#initialize' do
    context 'when creating a new pencil' do
      it 'returns a new pecil with given point durability' do
        expect(myPencil.pointDurability).to eq 25
      end
      it 'returns a new pecil with given point durability' do
        expect(myPencil.length).to eq 10
      end
      it 'returns a blank file' do
        expect(File.read(path).strip).to eq ""
      end
    end

    # context 'when the plane is not flying' do
    #   it 'returns false' do
    #     expect(Airplane.new.flying?).to eq false
    #   end
    # end
  end

  describe '#write' do
    context 'when writing text to the SheetOfPaper.txt file with the pencil' do
      it 'degrades the point durability' do
        myPencil.write("Hi")
        expect(myPencil.pointDurability).to eq 22
        myPencil.write(" I am a blank piece of paper")
        expect(myPencil.pointDurability).to eq 0
        myPencil.write(" Good Bye ")
        expect(myPencil.pointDurability).to eq 0
        expect(File.read(path).size).to eq 40
      end
      it 'returns a letter in exchange of point durability' do

        expect(File.read(path)).to eql "Hi I am a blank piece of paper          "

      end
    end
  end
end
