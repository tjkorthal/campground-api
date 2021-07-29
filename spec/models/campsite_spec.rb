require 'rails_helper'

RSpec.describe Campsite, type: :model do
  it { should belong_to(:campground) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price_usd) }
end
