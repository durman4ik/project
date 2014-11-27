class Comment < ActiveRecord::Base

  validates :body, length: {
    maximum: 1200,
    too_long: "%{count} characters is the maximum allowed"
  }

  belongs_to :scheme
  belongs_to :user

end
