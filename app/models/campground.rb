class Campground < ApplicationRecord
  has_many :campsites, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  def attributes
    {
      'id' => id,
      'name' => name,
      'booked_dates' => booked_dates,
      'price_range' => price_range
    }
  end

  def self.available(date_range)
    formatted_range = date_range.map { |date| "'#{date}'" }.join(', ')
    connection.execute(%[
      SELECT DISTINCT campgrounds.* FROM campgrounds
      INNER JOIN campsites ON campgrounds.id = campsites.campground_id
      WHERE campsites.id NOT IN (
        SELECT DISTINCT campsites.id FROM campsites
        INNER JOIN bookings ON campsites.id = bookings.campsite_id
        INNER JOIN booked_days ON bookings.id = booked_days.booking_id
        WHERE booked_days.date IN (#{formatted_range})
      )
    ])
  end

  def booked_dates
    all_dates = campsites.map(&:booked_dates).flatten.uniq
    all_dates.select do |date|
      campsites.all? { |campsite| campsite.booked_dates.include?(date) }
    end
  end

  def price_range
    prices = campsites.map(&:price_usd)
    "$#{prices.min}-#{prices.max}"
  end
end
