class AddColumnToCtaStations < ActiveRecord::Migration[5.0]
  def change
    add_column :cta_stations, :stop_id, :integer
  end
end
