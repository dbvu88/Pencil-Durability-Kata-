require_relative "../pencil"

RSpec.describe Pencil do

myPencil = Pencil.new(100,10)
  describe '#initialize' do
    context 'when creating a new pencil with a given point durability' do
      it 'returns a new pecil with that given point durability' do
        expect(myPencil.pointDurability).to eq 100
      end
      it 'returns an blank SheetOfPaper.txt file' do
        expect(File.read("SheetOfPaper.txt").strip).to eq ""
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
        expect(myPencil.pointDurability).to eq 97
        myPencil.write(" I am a blank piece of paper")
        expect(myPencil.pointDurability).to eq 75
      end
      it 'returns an blank SheetOfPaper.txt file' do
        expect(File.read("SheetOfPaper.txt").strip).to eql "Hi I am a blank piece of paper"
      end
    end
  end
end
