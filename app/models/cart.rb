class Cart < ApplicationRecord
	belongs_to :user
	belongs_to :product , class_name: "Product" 
end
