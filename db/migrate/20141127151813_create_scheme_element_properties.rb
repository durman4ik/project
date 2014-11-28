class CreateSchemeElementProperties < ActiveRecord::Migration
  def change
    create_table :scheme_element_properties do |t|
      t.integer :construction_id
      t.integer :property_id
      t.string  :value

    end
  end
end
