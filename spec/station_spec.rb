require 'station'

describe Station do
  subject(:station) { described_class.new(name: "Charing X") }

  it 'Knows it name' do
    expect(station.name).to eq(name: "Charing X")
  end


end
