class Element < ActiveRecord::Base

  has_many   :constructions
  has_many   :schemes, through: :constructions

  has_many   :properties

  accepts_nested_attributes_for :properties

  has_attached_file :image, :styles => { medium: "300x300>", thumb: "150x150>" }
  do_not_validate_attachment_file_type :image

end
