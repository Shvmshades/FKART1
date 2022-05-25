class Product < ApplicationRecord
  searchkick 

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :user

  has_many :cart_products
  has_many :carts, through: :cart_products

  has_one_attached :image

   validates :name,:description,:price,:quantity,  presence: true
  
  def search_data
    # {
    #   name: name,
    #   description: description
    # }

   { query: {
     multi_match: {
       fuzziness: 'AUTO',
       fields: %w[name description]
     }
   }}
  end
end

