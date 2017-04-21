# coding: utf-8
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

    it 'saves a new journey to @current_journey' do
      card.top_up(50)
      card.touch_in(station)
      expect(card.current_journey).to be_an_instance_of Journey
    end

    it 'sets the journey\'s @entry_station to station' do
      card.top_up(50)
      card.touch_in(station)
      expect(card.current_journey.entry_station).to eq station
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

    it 'Calls #complete_journey on #current_journey' do
      expect(card.current_journey).to receive(:complete_journey).with(station)
      card.touch_out(station)
    end

    it 'Sends @current_journey to @journeys' do
      current_journey = card.current_journey
      card.touch_out(station)
      expect(card.journeys).to include current_journey
    end

    it 'resets @current_journey to nil' do
      card.touch_out(station)
      expect(card.current_journey).to be_nil
    end

    context 'change balance' do
      it 'deducts fare' do
        expect { card.touch_out(station) }.to change { card.balance }.by(-Journey::FARE)
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

end
