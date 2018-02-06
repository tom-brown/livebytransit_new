class DeleteLatColumnsAndAddBack < ActiveRecord::Migration[5.0]
  def change
     remove_column :hood_points, :lat
     remove_column :hood_points, :lng
     remove_column :listings, :lat
     remove_column :listings, :lng
     remove_column :cta_stations, :lat
     remove_column :cta_stations, :lng
     remove_column :metra_stations, :lat
     remove_column :metra_stations, :lng
     add_column :hood_points, :lat, :float, default: 0
     add_column :hood_points, :lng, :float, default: 0
     add_column :listings, :lat, :float, default: 0
     add_column :listings, :lng, :float, default: 0 
     add_column :cta_stations, :lat, :float, default: 0
     add_column :cta_stations, :lng, :float, default: 0
     add_column :metra_stations, :lat, :float, default: 0
     add_column :metra_stations, :lng, :float, default: 0
  end
end
