class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|

    	t.string :title

    	t.string :composer_name
      t.integer :composer_id

    	t.string :album_name
    	t.integer :album_id

    	t.string :genre_name
    	t.integer :genre_id

  		t.timestamps
    end

    	add_index :songs, [:composer_id, :album_id, :genre_id]

  end
end