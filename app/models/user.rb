class User < ActiveRecord::Base

  TEMP_EMAIL_REGEX = /\Achange@me/
  
  has_attached_file :avatar, 
    :styles => { medium: "150x150>", thumb: "50x50>" },
    :default_url => '/images/:attachment/missing_:style.png'
  
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  validates :username,  presence: true,
                        uniqueness: { case_sensetive: false }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
         :omniauthable, :authentication_keys => [:login]

  has_many :schemes

  has_many :ratings
  has_many :rated_schemes, :through => :ratings, :source => :scheme

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        
        user = User.new(
          username: auth.info.name,
          email: email ? auth.info.email : "#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          avatar: auth.info.image
        )
        user.skip_confirmation!
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

end