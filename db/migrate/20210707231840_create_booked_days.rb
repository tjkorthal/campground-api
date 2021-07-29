class CreateBookedDays < ActiveRecord::Migration[6.1]
  def change
    create_table :booked_days do |t|
      t.date :date

      t.timestamps
    end

    add_reference :booked_days, :booking

    Campsite.connection.execute(%[
      CREATE UNIQUE INDEX IF NOT EXISTS unique_date_per_booking ON booked_days (date, booking_id);
    ])
  end
end
