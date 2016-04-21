class Journey

  MINIMUM_FARE = 1
  PENALTY = 6
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

  def correct?
    @current[:starting_station] && @current[:ending_station]
  end

  def fare
    #correct? ? MINIMUM_FARE : PENALTY
    fare_by_zone(current)
  end

  private

  def fare_by_zone(current)
    return PENALTY unless correct?
    1 + ( current[:starting_station].zone - current[:ending_station].zone ).abs
  end


end
