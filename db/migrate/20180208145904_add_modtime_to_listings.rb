class AddModtimeToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :modtime, :datetime
  end
end
