class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string               :title
      t.has_attached_file    :image
      t.integer              :num_inputs

      t.timestamps
    end
  end
end
