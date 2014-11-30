class CreateParametrs < ActiveRecord::Migration
  def change
    create_table :parametrs do |t|
      t.string  :name
      t.string  :value
      t.integer :construction_id
    end
  end
end
