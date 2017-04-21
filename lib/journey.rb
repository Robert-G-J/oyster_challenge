class Journey

  attr_reader :entry_station, :exit_station, :journey_complete, :fare
  FARE = 2

  def initialize(arg)
    @journey_complete = false
    @entry_station = arg
  end

  def complete_journey(exit_station)
    self.journey_complete = true
    self.exit_station = exit_station
    self.fare = FARE
    self
  end

  def journey_complete?
    journey_complete
  end

  private
  attr_writer :journey_complete, :exit_station, :fare
end
