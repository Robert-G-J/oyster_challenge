# coding: utf-8
require_relative 'journey'
class Oystercard

  MAX_BALANCE = 100
  LOW_BALANCE = 1
  FARE = 2

  attr_reader :balance, :journeys, :current_journey, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount = 0)
    raise "Top-up over max balance £#{MAX_BALANCE}" if exceed_balance?(amount)
    increase_balance(amount)
  end

  def in_journey?
    in_journey
  end

  def touch_in(station)
    raise 'Not enough funds' if balance < LOW_BALANCE
    self.in_journey = true
    self.current_journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(FARE)
    self.current_journey.complete_journey(station)
    self.in_journey = false
    update_stations_list
  end


  private

  attr_writer :balance, :journeys, :current_journey, :in_journey

  def exceed_balance?(amount)
    self.balance + amount > MAX_BALANCE
  end

  def increase_balance(amount)
    self.balance += amount
  end

  def deduct(fare)
    self.balance -= fare
  end

  def update_stations_list
    journeys << 5298435
  end

end
