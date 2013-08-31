class Setlist < ActiveRecord::Base
  attr_accessible :title, :description, :performance_date
                  # :song_attributes

  belongs_to :user
  has_many :tracks, order: :position, foreign_key: "tracker_id", dependent: :destroy
  has_many :songs, through: :tracks, source: :tracked

  # accepts_nested_attributes_for :songs

  validates :title, presence: true, length: { maximum: 42 }
  validates :description, length: { maximum: 80 }

  accepts_nested_attributes_for :tracks


  default_scope order: 'setlists.created_at DESC'

  def self.search(search)
  	if search

      where( "title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%" )
  	else
  		scoped
  	end
  end

  def tracking?(song)
    tracks.find_by_tracked_id(song.id)
  end

  def track!(song)
    tracks.create!(tracked_id: song.id)
  end

  def drop!(song)
    tracks.find_by_tracked_id(song.id).destroy
  end

end
