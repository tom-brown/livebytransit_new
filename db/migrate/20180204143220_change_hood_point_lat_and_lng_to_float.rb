class ChangeHoodPointLatAndLngToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column(:hood_points, :lat, :float)
    change_column(:hood_points, :lng, :float)
    change_column(:listings, :lat, :float)
    change_column(:listings, :lng, :float)
    change_column(:cta_stations, :lat, :float)
    change_column(:cta_stations, :lng, :float)
    change_column(:metra_stations, :lat, :float)
    change_column(:metra_stations, :lng, :float)
  end
end
