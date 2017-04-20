require 'station'

describe Station do
  subject(:station) { described_class.new('Charing X', 1) }

  it 'Knows its name' do
    expect(station.name).to eq('Charing X')
  end

  it 'Knows its zone' do
    expect(station.zone).to eq(1)
  end

end
