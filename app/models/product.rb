class Product < ApplicationRecord
	has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
	belongs_to :user
	
	has_many :cart_products
  has_many :carts, through: :cart_products

  has_one_attached :image
end
