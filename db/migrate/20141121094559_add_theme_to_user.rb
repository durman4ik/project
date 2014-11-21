class AddThemeToUser < ActiveRecord::Migration
  def up
    add_column :users, :theme, :string
  end

  def down
    remove_column :users, :theme
  end 

end
