class Album < ActiveRecord::Base
  attr_accessible :album_name, :composer_name, :composer_id

  belongs_to :composer
  has_many :songs

  accepts_nested_attributes_for :songs

  def to_label
  	"#{album_name}"
  end

end
