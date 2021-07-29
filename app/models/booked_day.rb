class BookedDay < ApplicationRecord
  belongs_to :booking

  validates_presence_of :date
  validate :date, :date_is_available

  def self.create_for_range(date_range, booking_id)
    date_range.map do |day|
      BookedDay.create!(booking_id: booking_id, date: day)
    end
  end

  private

  def date_is_available
    return unless booking.campsite.booked_dates.include?(date)

    errors.add(:date, "already taken")
  end
end
