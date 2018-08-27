require 'rails_helper'

describe Party do

  describe 'creating a Party' do
    let(:party_attrs) {
      { id: 'A123', name: 'Foo party', description: 'a big party description' }
    }

    let(:party) { Party.new(party_attrs) }

    it 'has an id' do
      expect(party.id).to eq('A123')
    end

    it 'has a name' do
      expect(party.name).to eq('Foo party')
    end

    it 'has a description' do
      expect(party.description).to eq('a big party description')
    end

    it 'can be created without a description' do
      expect(Party.new(id: '123', name: 'name').description).to eq('')
    end
  end

  describe 'registering parties' do
    let(:parties) {
      [
        { id: 'A123', name: 'Foo party', description: 'a big party description' },
        { id: 'B456', name: 'Some other party', description: 'another party' },
        { id: 'C987', name: 'Third party', description: 'Some third party' },
        { id: 'C987', name: 'Third party', description: 'A duplicate of Third Party' }
      ]
    }

    before do
      parties.each { |attrs| Party.register(attrs) }
    end

    it 'indexes party by the :name' do
      party = Party.find('A123')

      expect(party.id).to eq('A123')
      expect(party.name).to eq('Foo party')
      expect(party.description).to eq('a big party description')
    end

    it 'returns nil if the party does not exist' do
      expect(Party.find('zzzz')).to be_nil
    end

    it 'returns the most recently-added party by id' do
      party = Party.find('C987')

      expect(party.description).to eq('A duplicate of Third Party')
    end
  end

end
