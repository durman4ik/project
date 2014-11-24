class CreateSchemes < ActiveRecord::Migration
  def change
    create_table :schemes do |t|
    	t.string 	  :title
    	t.text      :description
    	t.integer   :rating, 	null: false, default: 0
    	t.integer   :user_id

      t.timestamps
    end
  end
end
