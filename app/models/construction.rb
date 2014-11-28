class Construction < ActiveRecord::Base
  
  belongs_to :scheme
  belongs_to :element

  has_many :scheme_element_properties
  has_many :properties, through: :scheme_element_properties

end
