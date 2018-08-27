require 'rails_helper'

describe Office do
  let(:alderman) {{ id: 'ON001', name: 'Alderman', description: 'Desc for Alderman' }}
  let(:clerk) {{ id: 'ON016', name: 'Clerk', description: 'Desc for Clerk' }}
  let(:selectman) {{ id: 'ON146', name: 'Selectman', description: 'Desc for Selectman' }}


  describe 'creating an Office' do
    let(:office) { Office.new(alderman) }

    it 'has an id' do
      expect(office.id).to eq(alderman[:id])
    end

    it 'has a name' do
      expect(office.name).to eq(alderman[:name])
    end

    it 'has a description' do
      expect(office.description).to eq(alderman[:description])
    end

    it 'can be created without a description' do
      expect(Office.new(id: '123', name: 'name').description).to eq('')
    end
  end

  describe 'registering offices' do
    context 'normally' do
      before do
        [alderman, clerk, selectman].each { |attrs| Office.register(attrs) }
      end

      it 'indexes office by the :id' do
        office = Office.find(alderman[:id])

        expect(office.id).to eq(alderman[:id])
        expect(office.name).to eq(alderman[:name])
        expect(office.description).to eq(alderman[:description])
      end

      it 'returns nil if the office does not exist' do
        expect(Office.find('zzzz')).to be_nil
      end
    end

    context 'with duplicate entries' do
      let(:duplicate) {{ id: 'ON146', name: 'Selectman 2', description: 'Duplicate Selectman Entry' }}

      before do
        [selectman, duplicate].each { |attrs| Office.register(attrs) }
      end

      it 'returns the most recently-added office by id' do
        office = Office.find(selectman[:id])

        expect(office.description).to eq('Duplicate Selectman Entry')
      end
    end
  end

end
