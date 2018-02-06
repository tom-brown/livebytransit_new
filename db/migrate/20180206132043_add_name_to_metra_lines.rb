class AddNameToMetraLines < ActiveRecord::Migration[5.0]
  def change
    add_column :metra_lines, :name, :string
  end
end
