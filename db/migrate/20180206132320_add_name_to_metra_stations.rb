class AddNameToMetraStations < ActiveRecord::Migration[5.0]
  def change
    add_column :metra_stations, :name, :integer
  end
end
