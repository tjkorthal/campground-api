class Booking < ApplicationRecord
  belongs_to :campsite
  has_many :booked_days, dependent: :destroy

  def attributes
    {
      'id' => id,
      'campsite_id' => campsite_id,
      'booked_dates' => booked_dates,
      'created_at' => created_at,
      'updated_at' => updated_at
    }
  end

  def booked_dates
    booked_days.map(&:date)
  end
end
