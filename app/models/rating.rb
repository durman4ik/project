class Rating < ActiveRecord::Base

  belongs_to :scheme
  belongs_to :user

end
