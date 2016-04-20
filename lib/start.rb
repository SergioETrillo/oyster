require './lib/oystercard'
card = Oystercard.new
card.top_up(90)
card.touch_in("a")
card.touch_out("b")
puts "Current Journey 1:", card.journey.current
card.touch_in("c")
card.touch_out("d")
puts "Current Journey 2:", card.journey.current
card.touch_in("e")
card.touch_out("f")
puts "Current Journey 3:", card.journey.current
puts "History:", card.journey.history
