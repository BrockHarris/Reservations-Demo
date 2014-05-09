class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
    	t.integer   :time
    	t.datetime  :date
    	t.integer   :guests
    	t.string    :name
      t.timestamps
    end
  end
end
