class AddThemeToUser < ActiveRecord::Migration
  def up
    add_column :users, :theme, :string
    add_column :schemes, :short_description, :text 
  end

  def down
    remove_column :users, :theme
    remove_column :schemes, :short_description
  end 

end
