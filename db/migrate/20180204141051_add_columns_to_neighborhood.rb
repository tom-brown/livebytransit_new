class AddColumnsToNeighborhood < ActiveRecord::Migration[5.0]
  def change
    add_column :neighborhoods, :minlat, :float
    add_column :neighborhoods, :minlng, :float
    add_column :neighborhoods, :maxlat, :float
    add_column :neighborhoods, :maxlng, :float
  end
end
