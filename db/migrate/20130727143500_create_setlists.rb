class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|
    	t.string :title
    	t.text :description
    	t.datetime :performance_date

    	t.integer :user_id

      t.timestamps
    end

    add_index :setlists, [:user_id, :performance_date]

  end
end
