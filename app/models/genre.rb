class Genre < ActiveRecord::Base
  attr_accessible :name

  has_many :songs

	accepts_nested_attributes_for :songs

end
