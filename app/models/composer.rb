class Composer < ActiveRecord::Base
  attr_accessible :name

  has_many :albums
  has_many :songs

  accepts_nested_attributes_for :songs

  validates :name, uniqueness: { case_sensitive: false }
  # validates :name, presence: true

  def self.search(search)
  	if search
      Composer.where("name ILIKE ?", "%#{search}%")
  	else
  		scoped
  	end
  end

end
