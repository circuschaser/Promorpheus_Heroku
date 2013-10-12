# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).



# Composer.delete_all
# CSV.foreach("doc/Composers.csv", headers: true) do |row|
# 	Composer.create! row.to_hash
# end


# Album.delete_all
# CSV.foreach("doc/Albums.csv", headers: true) do |row|	
# 	c = Composer.find_by_name row["composer_name"]	
# 	a = c.albums.create! row.to_hash
# end


# Genre.delete_all
# CSV.foreach("doc/Genres.csv", headers: true) do |row|
# 	Genre.create! row.to_hash
# end

Song.destroy_all
CSV.foreach("doc/Songs.csv", headers: true) do |row|
	a = Album.find_by_album_name row["album_name"]
	a.songs.create! row.to_hash
	s = Song.find_by_title row["title"]
	s.update_attribute(:genre_id, (Genre.find_by_name s.genre_name).id)
	s.update_attribute(:composer_id, (Composer.find_by_name s.composer_name).id)
end

songs = Song.all
songs.each do |s|
	s.update_attribute(:tag_list, [])
end

3.times do
	CSV.foreach("doc/Tags.csv", headers: false) do |row|
		s = Song.all.shuffle.pop
		s.update_attribute(:tag_list, row)
	end
end

# 1000.times do
#   Person.create :name => "#{Faker::Name.first_name} #{Faker::Name.last_name}"
# end