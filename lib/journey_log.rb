require 'journey'

class JourneyLog

  attr_reader :journey

  def initialize(journey = Journey.new)
    @journey = journey
    @history = []
  end

  def get_history
    @history
  end
private
  def update_history
    @history << journey.current.dup
  end

end