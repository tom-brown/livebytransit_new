class CreateCtaProxes < ActiveRecord::Migration[5.0]
  def change
    create_table :cta_proxes do |t|
      t.integer :listing_id
      t.integer :cta_station_id

      t.timestamps
    end
  end
end
