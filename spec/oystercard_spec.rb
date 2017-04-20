require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station) { double(:station) }

  describe '#balance' do
    it 'Should return 0 balance' do
      expect(card.balance).to eq(0)
    end
    it 'Raises an error' do
      low_balance = Oystercard::LOW_BALANCE
      card.top_up(low_balance - 1)
      expect { card.touch_in(station) }.to raise_error 'Not enough funds'
    end
  end

  describe '#top_up' do
    it 'Expects #top_up to change balance' do
      expect { card.top_up(10) }.to change { card.balance }.by(10)
    end

    it 'Should raise error if top up breaches limit' do
      max_balance = Oystercard::MAX_BALANCE
      card.top_up(max_balance)
      expect { card.top_up(1) }.to raise_error "Top-up over max balance £#{max_balance}"
    end
  end

  describe '#touch_in' do
    it 'changes #in_journey? to true' do
      card.top_up(10)
      expect { card.touch_in(station) }.to change { card.in_journey? }.to true
    end
  end

  describe '#touch_out' do
    before do
      card.top_up(10)
      card.touch_in(station)
    end

    it 'changes #in_journey to false' do
      expect { card.touch_out(station) }.to change { card.in_journey? }.to false
    end

    context 'change balance' do
      it 'deducts fare' do
        expect { card.touch_out(station) }.to change { card.balance }.by(-Oystercard::FARE)
      end
    end
  end

  describe '#journeys' do
    let(:journey) { { entry: station, exit: station } }

    before do
      card.top_up(10)
      card.touch_in(station)
      card.touch_out(station)
    end

    it 'resets the entry_station when you touch_out' do
      expect(card.entry_station).to be_nil
    end

    it 'should store the journeys in a hash' do
      expect(card.journeys).to include journey
    end
  end

end
