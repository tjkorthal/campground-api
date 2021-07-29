class CreateCampsite < ActiveRecord::Migration[6.1]
  def change
    create_table :campsites do |t|
      t.string :name, null: false
      t.float :price_usd, default: 0.0

      t.timestamps
    end

    add_reference :campsites, :campground

    Campsite.connection.execute(%[
      CREATE UNIQUE INDEX IF NOT EXISTS unique_campsite_name ON campsites (name, campground_id);
    ])
  end
end
