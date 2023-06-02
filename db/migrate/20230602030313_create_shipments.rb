class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :address
      t.string :building_name
      t.string :phone_number
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
