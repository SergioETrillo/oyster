class Journey
  attr_reader :current, :starting_station, :ending_station

  @@history ||= []

  def initialize
    @starting_station = nil
    @ending_station = nil
    @current = {}
  end

  def start_journey(station)
    @current[:starting_station] = station
  end

  def end_journey(station)
    @current[:ending_station] = station
    @@history << current.dup
    @current
    # @current = {}
  end

  def complete?
    !!@current[:ending_station]
  end

  def get_history
    @@history
  end

end
