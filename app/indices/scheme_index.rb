ThinkingSphinx::Index.define :scheme, with: :active_record do
  indexes title, short_description, description, as: :user_scheme
  indexes rating, sortable: true
  # indexes scheme.ratings

  indexes user.username, as: :name

  has user(:id), as: :user_id
  

end