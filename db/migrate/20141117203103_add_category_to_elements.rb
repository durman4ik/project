class AddCategoryToElements < ActiveRecord::Migration
  def up
    add_column :elements, :category, :string
  end

  def down
    remove_column :elements, :category
  end
end
