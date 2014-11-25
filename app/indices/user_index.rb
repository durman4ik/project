ThinkingSphinx::Index.define :user, with: :active_record do
  indexes username
  indexes id, as: :user_id

  has schemes(:user_id)

end