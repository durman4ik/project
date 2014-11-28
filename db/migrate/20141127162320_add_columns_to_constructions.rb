class AddColumnsToConstructions < ActiveRecord::Migration
  
  def change
    change_table :constructions do |t| 
      t.integer :width
      t.integer :height
      t.string  :color
      t.string  :users_title
      
    end
  end

end
