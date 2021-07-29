class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :bookings, dependent: :destroy
  has_many :booked_days, through: :bookings

  validates_presence_of :name, :price_usd
  validates_uniqueness_of :name, scope: :campground_id

  def attributes
    {
      'id' => id,
      'campground_id' => campground_id,
      'name' => name,
      'booked_dates' => booked_dates,
      'price_usd' => price_usd
    }
  end

  def booked_dates
    booked_days.map(&:date)
               .sort
  end
end
