class CreateProductCategories < ActiveRecord::Migration[7.0]
  def up
    create_table :product_categories do |t|
      t.references :product, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :product_categories
  end
end
