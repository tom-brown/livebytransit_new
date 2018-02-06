class ChangeNameToBeStringInMetraStations < ActiveRecord::Migration[5.0]
  def change
    change_column :metra_stations, :name, :string
  end
end
