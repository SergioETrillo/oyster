class Journey

  attr_reader :journeys, :entry_station

  def initialize
    @journeys = []
  end

  def in_journey?
    !!entry_station
  end
end
