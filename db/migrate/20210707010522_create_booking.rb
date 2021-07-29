class CreateBooking < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.timestamps
    end

    add_reference :bookings, :campsite
  end
end
