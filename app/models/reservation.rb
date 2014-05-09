class Reservation < ActiveRecord::Base
  attr_accessible :time, :date, :guests, :name

  validates :name, :presence => true, :length=>{:minimum => 3}
  validates :time, :inclusion => 5..8
  validates :date, :presence => true
  validates :guests, :inclusion => 2..4
  
  validate :availability

  private

  def reservation_taken
  	# Check if any reservations already exist on the day requested
  	days_booked = Reservation.where("strftime('%m/%d', date) = ? AND guests = ?", self.date.strftime('%m/%d'), self.guests)
  	if days_booked.empty?
  		return false # No reservations on that day, time slot is available
  	elsif time_open(days_booked) 
  		return false # No reservation conflicts, time slot is available
  	else
  		return true
  	end  
  end

  def time_open(days_booked)
  	open = true
  	# Check to make sure there aren't any time conflicts (reservations are 2 hours long)
  	days_booked.each do |slot|
  		if self.time == slot.time || self.time == (slot.time + 1) || self.time == (slot.time - 1)
  			open = false
  		end
  	end
  	return open
  end

  def availability
  	errors.add("This reservation time", "isn't available") if reservation_taken
	end
end
