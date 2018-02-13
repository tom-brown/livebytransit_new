class AddStatusToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :status, :string
  end
end
