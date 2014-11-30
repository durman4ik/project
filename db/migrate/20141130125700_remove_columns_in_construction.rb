class RemoveColumnsInConstruction < ActiveRecord::Migration
  def up
    remove_column :constructions, :cordx
    remove_column :constructions, :cordy
    remove_column :constructions, :quantity
    remove_column :constructions, :width
    remove_column :constructions, :height
    remove_column :constructions, :color
    add_column    :constructions, :parametrs_id, :integer
    add_column    :constructions, :tips, :string
  end

  def down
    add_column    :constructions, :cordx, :string
    add_column    :constructions, :cordy, :string
    add_column    :constructions, :quantity, :integer
    add_column    :constructions, :width, :integer
    add_column    :constructions, :height, :integer
    add_column    :constructions, :color, :string
    remove_column :constructions, :parametrs_id
    remove_column :constructions, :tips
  end
end
