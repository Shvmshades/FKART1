class User < ApplicationRecord
	has_secure_password
	has_many :carts
	has_many :products, :through => :carts
	has_and_belongs_to_many :roles
	validates  :name, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
	validates :password, presence: true
	
end
