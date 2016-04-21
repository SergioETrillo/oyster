class JourneyLog

  attr_reader :journey

  def initialize(journey=Journey.new)
    @journey = journey
    @history = []
  end

  def get_history
    @history.dup
  end

  def update_history(current_journey)
    @history << journey.current.dup
  end

end