class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.string :value, default: 0
      t.integer :element_id

      t.timestamps
    end
  end
end
