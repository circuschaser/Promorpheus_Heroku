class Song < ActiveRecord::Base

  attr_accessible :title,
                  :composer_name, :composer_id, :composer_attributes,
                  :album_name, :album_id, :album_attributes,
                  :genre_name, :genre_id, :genre_attributes,
                  :tag_list

  belongs_to :album
  belongs_to :genre
  belongs_to :composer

  before_save :set_composer
  before_save :set_album
  before_save :set_genre

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

  private
    def set_composer
      if !composer_id.nil?
        self.composer = Composer.find_by_id composer_id

      elsif composer_id.nil? && !composer_name.nil?
        self.composer = Composer.find_or_create_by_name composer_name
      
      else
        self.composer = Composer.find_or_create_by_name "Unknown Composer"
      end
    end

    def set_album
      if !album_id.nil?
        self.album = Album.find_by_id album_id

      elsif album_id.nil? && !album_name.nil?
        self.album = Album.find_or_create_by_album_name album_name
      
      else
        self.album = Album.find_or_create_by_album_name "Unknown Album"
      end
    end

    def set_genre
      if !genre_id.nil?
        self.genre = Genre.find_by_id genre_id

      elsif genre_id.nil? && !genre_name.nil?
        self.genre = Genre.find_or_create_by_name genre_name
      
      else
        self.genre = Genre.find_or_create_by_name "Unknown Genre"
      end
    end

end
