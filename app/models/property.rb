class Property < ActiveRecord::Base

  has_many   :scheme_element_properties
  has_many   :constructions, through: :scheme_element_properties

  belongs_to :element

end
