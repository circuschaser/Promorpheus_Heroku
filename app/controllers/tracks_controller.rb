class TracksController < ApplicationController

	def index
		@tracks = Track.order('tracks.position ASC')
		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @tracks }
	      format.js
	    end
	end

	def new
		@track = Track.new
	end

	def create
		@setlist = Setlist.find(params[:track][:tracker_id])
		last = @setlist.tracks.last.position
		@song = Song.find(params[:track][:tracked_id])
		
		@setlist.track!(@song)
		t = @setlist.tracks.last
		t.update_attribute(:position, last + 1 )
		
		flash[:success] = "The song: \"#{@song.title.upcase}\" was successfully added to this Setlist"
		redirect_to "/setlists/#{@setlist.id}"

		rescue ActiveRecord::RecordNotFound
  			redirect_to "/setlists/#{@setlist.id}"
			flash[:error] = 'SONG NOT ADDED. You did not choose a song.' 			
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
