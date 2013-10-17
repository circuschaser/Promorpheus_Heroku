# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).



Composer.delete_all

Album.delete_all

Genre.delete_all

Song.destroy_all
CSV.foreach("doc/Songs.csv", headers: true) do |row|
	Song.create! row.to_hash
end

# songs = Song.all
# songs.each do |s|
	# s.update_attribute(:tag_list, [])
# end

3.times do
	CSV.foreach("doc/Tags.csv", headers: false) do |row|
		s = Song.all.shuffle.pop
		s.update_attribute(:tag_list, row)
	end
end

# 1000.times do
#   Person.create :name => "#{Faker::Name.first_name} #{Faker::Name.last_name}"
# end