class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.integer    :element_id
      t.integer    :scheme_id
      t.float      :cordx
      t.float      :cordy
      t.integer    :quantity

      t.timestamps
    end
  end
end
