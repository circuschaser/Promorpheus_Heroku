class Track < ActiveRecord::Base
  attr_accessible :tracked_id, :tracker_id, :position

  belongs_to :tracker, class_name: "Setlist"
  belongs_to :tracked, class_name: "Song"

  # validates :position, presence: true
  # acts_as_list scope: :setlist

end
