class CreateCarts < ActiveRecord::Migration[7.0]
  def up
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :carts
  end

end
