class CreateProducts < ActiveRecord::Migration[7.0]
  def up
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price, precision: 8, scale:2, null:false
      
      t.timestamps
    end
  end

  def down
  drop_table :products
  end
end
