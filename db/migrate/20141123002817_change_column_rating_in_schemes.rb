class ChangeColumnRatingInSchemes < ActiveRecord::Migration
  def up
    change_column :schemes, :rating, :float
  end

  def down
    change_column :schemes, :rating, :integer
  end
end
