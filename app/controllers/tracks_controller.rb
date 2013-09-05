class TracksController < ApplicationController

	def index
		@tracks = Track.order('tracks.position ASC').paginate(per_page: 10, page: params[:page])
	end

	def new
		@track = Track.new
	end

	def create
		@setlist = Setlist.find(params[:track][:tracker_id])
		last = @setlist.tracks.last
		@song = Song.find(params[:track][:tracked_id])
		
		@setlist.track!(@song)
		if last.nil?
			t = @setlist.tracks.last
			t.update_attribute(:position, 1 )
		else
			t = @setlist.tracks.last
			t.update_attribute(:position, last.position + 1 )
		end
		
		flash[:success] = "The song: \"#{@song.title.upcase}\" was successfully added to the setlist: \"#{@setlist.title.upcase}\""
		redirect_to :back

		rescue ActiveRecord::RecordNotFound
  			redirect_to :back
			flash[:error] = 'SONG NOT ADDED. You failed to make a choice.' 			
	end

	def destroy
		@setlist = Track.find(params[:id]).tracker
		@song = Track.find(params[:id]).tracked
		@setlist.drop!(@song)
		flash[:alert] = "The song: \"#{@song.title.upcase}\" was successfully removed from this Setlist"		
		redirect_to "/setlists/#{@setlist.id}"
	end

	def sort
		params[:track].each_with_index do |id, index|
			Track.update_all({position: index+1}, {id: id})
		end
		render nothing: true
	end

end
