class Scheme < ActiveRecord::Base
	
	validates  :title, presence: true
  belongs_to :user

  has_many   :constructions
  has_many   :elements, through: :constructions

end
