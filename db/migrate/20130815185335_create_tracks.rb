class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :tracker_id
      t.integer :tracked_id
      t.integer :position

      t.timestamps
    end

    add_index :tracks, :tracker_id
    # add_index :tracks, :tracked_id
    # add_index :tracks, [:tracker_id, :tracked_id], unique: true
  end
end
