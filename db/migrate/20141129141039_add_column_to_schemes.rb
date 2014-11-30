class AddColumnToSchemes < ActiveRecord::Migration
  def up
    add_column :schemes, :published, :boolean, default: false
    add_attachment :schemes, :scheme_image 
  end

  def down
    remove_column :schemes, :published
    remove_attachment :schemes, :scheme_image
  end
end
