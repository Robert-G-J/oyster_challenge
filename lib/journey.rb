class Journey

  attr_reader :entry_station, :journey_complete

  def initialize(arg)
    @journey_complete = false
    @entry_station = arg
  end

end
