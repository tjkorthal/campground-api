class CreateCampground < ActiveRecord::Migration[6.1]
  def change
    create_table :campgrounds do |t|
      t.string :name, null: false

      t.timestamps
    end

    Campground.connection.execute(%[
      CREATE UNIQUE INDEX IF NOT EXISTS unique_campground_name ON campgrounds (name)
    ])
  end
end
