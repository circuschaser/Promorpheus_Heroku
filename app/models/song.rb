class Song < ActiveRecord::Base
  attr_accessible :title,
                  :composer_name, :composer_id, :composer_attributes,
                  :album_name, :album_id, :album_attributes,
                  :genre_name, :genre_id, :genre_attributes,
                  :tag_list

  belongs_to :album
  belongs_to :genre
  belongs_to :composer

  # has_and_belongs_to_many :tags, join_table: "songs_tags"

  has_many :tracks, foreign_key: "tracked_id", dependent: :destroy
  has_many :setlists, through: :tracks, source: :tracker

  acts_as_taggable # basic usage
  # acts_as_taggable_on :topics

  accepts_nested_attributes_for :album
  accepts_nested_attributes_for :genre
  accepts_nested_attributes_for :composer

  validates :title, presence: true

  default_scope order: 'title ASC'


  def self.search(search)
  	if search
  		select('distinct songs.*').joins("LEFT JOIN taggings on songs.id = taggings.taggable_id")
      .joins("LEFT JOIN tags on tags.id = taggings.tag_id")
      .where("tags.name ILIKE ? OR title ILIKE ? OR composer_name ILIKE ? OR album_name ILIKE ? OR genre_name ILIKE ?",
              "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  	else
  		scoped
  	end
  end

  def tracked?(setlist)
    tracks.find_by_tracker_id(setlist.id)
  end

end
