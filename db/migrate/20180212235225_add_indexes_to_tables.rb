class AddIndexesToTables < ActiveRecord::Migration[5.0]
  def change
    add_index :listings, [:lat, :lng]
    add_index :cta_stations, [:lat, :lng]
    add_index :metra_stations, [:lat, :lng]
  end
end
