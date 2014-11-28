class SchemeElementProperty < ActiveRecord::Base

  belongs_to :construction
  belongs_to :property
  
end
