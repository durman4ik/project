class Construction < ActiveRecord::Base
  
  belongs_to :scheme
  belongs_to :element

  has_many :parametrs, dependent: :destroy

  has_many :scheme_element_properties, dependent: :destroy
  has_many :properties, through: :scheme_element_properties

end
