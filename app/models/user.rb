class User < ActiveRecord::Base
  #mount_uploader :avatar, AvatarUploader
  has_many :schemes

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username, presence: true

end