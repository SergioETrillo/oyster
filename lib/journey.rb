class Journey
 MINIMUM_FARE = 1
 PENALTY_FARE = 6
 attr_accessor :journey,:entry_station,:exit_station

  def initialize
  	@journey = {}
  end

  def start_journey(entry_station)
  	self.journey[:entry_station] = entry_station
    @entry_station = entry_station
  end

  def finish_journey(exit_station)
  	self.journey[:exit_station] = exit_station
    @exit_station = exit_station
  end

  def journey_complete?
    !!(entry_station && exit_station)
    #(entry_station == nil || exit_station == nil)? false : true
  end

  def fare
  	return MINIMUM_FARE if journey_complete?
    PENALTY_FARE
  end

end
