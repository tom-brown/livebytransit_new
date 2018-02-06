class AddStationIdToMetraStations < ActiveRecord::Migration[5.0]
  def change
    add_column :metra_stations, :station_id, :integer
  end
end
