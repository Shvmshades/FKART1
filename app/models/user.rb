class User < ApplicationRecord
	before_create :confirmation_token
	after_save :role_define
	has_secure_password

	has_many :products ,dependent: :destroy
	has_and_belongs_to_many :roles
	has_one :cart  
  
	validates  :name, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
	validates :password,
	:confirmation => true,
	:allow_blank => true,
	:on => :update
    


 # def self.email_activate user
 #    user.email_confirmed = true
 #    user.confirm_token = nil
 #    user.save!(:validate => false)
 #    #debugger
 # end

  def email_activate
  	self.email_confirmed = true
  	self.confirm_token = nil
  	self.save!(:validate => false)
  end

  
  private

	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end

	def role_define
    self.roles.create(name:"Buyer")
  end
end
