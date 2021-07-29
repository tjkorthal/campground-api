require 'csv'

namespace :csv do
  desc "Import Campsite Data"
  task campsite_import: :environment do
    file_path = Rails.root.join('lib', 'sample_campground_data.csv').to_s
    campground_map = Hash.new { |h, k| h[k] = [] }

    CSV.foreach(file_path, headers: true) do |row|
      campground_name = row['campground_name']
      campground_map[campground_name].push(
        name: row['campsite_name'],
        price_usd: row['price_usd']
      )
    end

    campground_map.each do |campground_name, campsites|
      campground = Campground.create!(name: campground_name)
      campsites.each do |campsite|
        Campsite.create!(
          campground_id: campground.id,
          name: campsite[:name],
          price_usd: campsite[:price_usd]
        )
      end
    end
  end
end
