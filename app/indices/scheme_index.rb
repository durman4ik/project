ThinkingSphinx::Index.define :scheme, with: :active_record do

  indexes title, short_description, description
  indexes rating, sortable: true
  indexes user.username, as: :name

  has user(:id), as: :user_id
  
end