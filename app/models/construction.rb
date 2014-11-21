class Construction < ActiveRecord::Base
  
  belongs_to :scheme
  belongs_to :element

end
