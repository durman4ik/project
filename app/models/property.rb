class Property < ActiveRecord::Base

  has_many   :scheme_element_properties
  has_many   :constructions, through: :scheme_element_properties

  belongs_to :element

  def can_destoy_property(element)
    element.properties.length > 1
  end

end
