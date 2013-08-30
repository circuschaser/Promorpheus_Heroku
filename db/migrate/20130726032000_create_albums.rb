class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.string :album_name
    	t.string :composer_name
    	
    	t.integer :composer_id

      t.timestamps
    end

    add_index :albums, :composer_id

  end
end
