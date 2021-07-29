require 'rails_helper'

RSpec.describe Campground, type: :model do
  it { should have_many(:campsites) }
  it { should validate_presence_of(:name) }
end
