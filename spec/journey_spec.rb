require 'journey'

describe Journey do
  let (:entry_station) { double(:station, :name => "Blackfriars!", :zone => 2) }
  subject { described_class.new(entry_station) }

  it 'has an entry station' do
    expect(subject.entry_station).to eq entry_station
  end

  it 'is not complete' do
    expect(subject.journey_complete).to be false
  end

end
