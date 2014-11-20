class User < ActiveRecord::Base
  has_many :schemes
  has_attached_file :avatar, 
    :styles => { medium: "300x300>", thumb: "150x150>" },
    :default_url => '/images/:attachment/missing_:style.png'
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username,  presence:   true

  # with_options if: :if_admin? do |admin|
  #   admin.validates :email, :password, presence: false
  #   admin.validates :password, presence: false
  # end

  def if_admin?
    current_user.role == "admin"
  end

end