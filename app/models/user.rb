class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  
  has_attached_file :avatar, 
    :styles => { medium: "150x150>", thumb: "50x50>" },
    :default_url => '/images/:attachment/missing_:style.png'
  
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  validates :username,  presence:   true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :schemes

  has_many :ratings
  has_many :rated_schemes, :through => :ratings, :source => :scheme

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
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

    # Associate the identity with the user if needed
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