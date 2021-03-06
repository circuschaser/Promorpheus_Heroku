class SetlistsController < ApplicationController

	def new
		@setlist = Setlist.new
	end

	def index
		sets = current_user.setlists
		@setlists = sets.search(params[:search]).paginate(per_page: 10, page: params[:page])
	end

	def active
		sets = current_user.setlists.active
		@setlists = sets.search(params[:search]).paginate(per_page: 10, page: params[:page])
	end

	def archived
		sets = current_user.setlists.archived
		@setlists = sets.search(params[:search]).paginate(per_page: 10, page: params[:page])
	end

	def show
		@setlist = Setlist.find(params[:id])
		@songs = @setlist.songs
	end

	def update
		@setlist = Setlist.find(params[:id])
		if @setlist.update_attributes(params[:setlist])
			flash.now[:success] = "The setlist: \"#{@setlist.title.upcase}\" was successfully updated"
			render 'show'
			# redirect_to setlists_path
		else
	      flash.now[:error] = "Whoops. SOMETHING WENT WRONG.\nYou're probably missing a TITLE. Check the form again."
			render 'show'
		end
	end

	def create
		@setlist = Setlist.new(params[:setlist])
		current_user.setlists << @setlist
		if @setlist.save
			flash[:success] = "The setlist: \"#{@setlist.title.upcase}\" was successfully created"
			redirect_to @setlist
		else
	        render 'new'
	    end
	end

	def archive
		@setlist = Setlist.find(params[:id])
		@setlist.active = false
		if @setlist.save
			flash[:success] = "The setlist: \"#{@setlist.title.upcase}\" was succesfully archived"
			@setlist.touch
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nArchive failed."
			redirect_to :back
		end
	end

	def unarchive
		@setlist = Setlist.find(params[:id])
		@setlist.active = true
		if @setlist.save
			flash[:success] = "The setlist: \"#{@setlist.title.upcase}\" was succesfully re-activated"
			@setlist.touch
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nActivation failed."
			redirect_to :back
		end
	end

	def tracking
		@title = "Tracking"
		@setlist = Setlist.find(params[:id])
		@songs = @setlist.tracked.paginate(per_page: 10, page: params[:page])
		render 'show'
	end

	def destroy
		title = Setlist.find(params[:id]).title
		Setlist.find(params[:id]).destroy
		flash[:alert] = "The setlist: \"#{title.upcase}\" was successfully dismantled"
		redirect_to :back
	end

end