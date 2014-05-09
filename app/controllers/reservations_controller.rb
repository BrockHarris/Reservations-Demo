class ReservationsController < ApplicationController
	
	def index
		@reservations = Reservation.all
		@reservation = Reservation.new
	end

	def create
		@reservations = Reservation.all
		@reservation = Reservation.new(params[:reservation])
		if @reservation.save
			redirect_to root_path
		else
			render :action => 'index'
		end
	end
end
