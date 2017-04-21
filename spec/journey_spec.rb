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

    it 'charges penalty fare by default' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    
    context '#complete_journey has been run' do

      before(:example) { journey.complete_journey(exit_station) }

      it 'sets #journey_complete true' do
        expect(journey.journey_complete).to be true
      end

      it 'sets @exit_station to its argument' do
        expect(journey.exit_station).to eq exit_station
      end

      it 'sets @fare to minimum fare' do
        expect(journey.fare).to eq Journey::FARE
      end
        

    end

  end
end
