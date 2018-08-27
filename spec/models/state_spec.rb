require 'rails_helper'
describe State do

  describe 'creating a State' do
    let(:state_attrs) {
      { name: 'Foo state', history: 'state history', bibliography: 'state bibliography' }
    }

    let(:state) { State.new(state_attrs) }

    it 'has a name' do
      expect(state.name).to eq('Foo state')
    end

    it 'has a history' do
      expect(state.history).to eq('state history')
    end

    it 'can be created without a history' do
      expect(State.new(name: 'name').history).to eq('')
    end

    it 'can be created without a bibliography' do
      expect(State.new(name: 'name').bibliography).to eq('')
    end
  end

  describe 'registering states' do
    let(:states) {
      [
        { name: 'Foo state', history: 'a big state history', bibliography: 'foo state bibliography' },
        { name: 'Some other state', history: 'another state', bibliography: 'other state bibliography'    },
        { name: 'Third state', history: 'Some third state', bibliography: 'third state bibliography' },
        { name: 'Third state', history: 'A duplicate of Third State', bibliography: 'third state duplicate bibliography' }
      ]
    }

    before do
      states.each { |attrs| State.register(attrs) }
    end

    it 'indexes state by the :name' do
      state = State.find('Foo state')

      expect(state.name).to eq('Foo state')
      expect(state.history).to eq('a big state history')
      expect(state.bibliography).to eq('foo state bibliography')
    end

    it 'returns nil if the state does not exist' do
      expect(State.find('zzzz')).to be_nil
    end

    it 'returns the most recently-added state by name' do
      state = State.find('Third state')

      expect(state.history).to eq('A duplicate of Third State')
    end
  end

end

