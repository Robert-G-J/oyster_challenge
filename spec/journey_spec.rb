require 'journey'

describe Journey do
  let (:entry_station) { double(:station, :name => "Blackfriars!", :zone => 2) }
  let (:exit_station) { double(:station, :name => "Montreal!", :zone => 30) }
  subject(:journey) { described_class.new(entry_station) }

  it 'has an entry station' do
    expect(journey.entry_station).to eq entry_station
  end

  it 'is not complete' do
    expect(journey.journey_complete).to be false
  end

  it { is_expected.to respond_to :exit_station }

  describe '#complete_journey' do
    it 'sets #journey_complete true' do
      journey.complete_journey(exit_station)
      expect(journey.journey_complete).to be true
    end
  end
end
