class User < ApplicationRecord
  
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

	attr_accessor :skip_confirmation_token, :skip_role_define
	before_create {confirmation_token unless skip_confirmation_token}
  after_save {role_define unless skip_role_define}
	
  has_secure_password

	has_many :products ,dependent: :destroy
	has_and_belongs_to_many :roles
	has_one :cart  
  
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
	validates :password,
	:confirmation => true,
	:allow_blank => true,
	:on => :update
    
  
  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_role_define = true
      user.save
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.email_confirmed = true
        user.skip_confirmation_token = true
      end
    end
    user
  end

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
