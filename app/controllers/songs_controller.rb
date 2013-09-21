class SongsController < ApplicationController

  before_filter :prepare_albums
  before_filter :prepare_composers
  before_filter :prepare_genres

  def new
    @song = Song.new
  end

  def index
    if params[:tag]
      @songs = Song.tagged_with(params[:tag]).paginate(per_page: 10, page: params[:page])
    else
      @songs = Song.search(params[:search]).paginate(per_page: 10, page: params[:page])
    end

    respond_to do |format|  
      format.html # index.html.erb  
      format.json { render json: @songs }
    end
  end

  def show
    @songs = Song.search(params[:search]).paginate(per_page: 10, page: params[:page])
  end


  def update
    @song = Song.find(params[:id])

    if @song.update_attributes(params[:song])
      s = @song
      if s.composer_name.empty?
        c = Composer.find_by_name "Unknown Composer"
        c.songs << s
        s.update_attribute(:composer_name, c.name)
      else
        c = Composer.find_or_create_by_name s.composer_name
        c.songs << s
      end

      if s.album_name.empty?
        a = Album.find_by_album_name "Unknown Album"
        a.songs << s
        s.update_attribute(:album_name, a.album_name)
      else
        a = Album.find_or_create_by_album_name s.album_name
        a.songs << s
      end

      if s.genre_name.empty?
        g = Genre.find_by_name "Unknown Genre"
        g.songs << s
        s.update_attribute(:genre_name, g.name)
      else
        g = Genre.find_or_create_by_name s.genre_name
        g.songs << s
      end

      flash[:success] = "The song: \"#{@song.title.upcase}\" was successfully updated"
      # redirect_to request.referer
      redirect_to songs_path
    else
      render 'edit'
    end
  end 

  def create
    @song = Song.new(params[:song])

    if @song.save

      s = @song
      if s.composer_id.nil? || s.composer.name.empty?
        c = Composer.find_by_name "Unknown Composer"
        c.songs << s
        s.update_attribute(:composer_name, c.name)
        z = Composer.find_by_name ""
        z.destroy unless z.nil?
      else
        c = Composer.find_by_id s.composer_id
        s.update_attribute(:composer_name, c.name)
      end

      if s.album_id.nil? || s.album.album_name.empty?
        a = Album.find_by_album_name "Unknown Album"
        a.songs << s
        s.update_attribute(:album_name, a.album_name)
        z = Album.find_by_album_name ""
        z.destroy unless z.nil?
      else
        a = Album.find_by_id s.album_id
        s.update_attribute(:album_name, a.album_name)
      end

      if s.genre_id.nil? || s.genre.name.empty?
        g = Genre.find_by_name "Unknown Genre"
        g.songs << s
        s.update_attribute(:genre_name, g.name)
        z = Genre.find_by_name ""
        z.destroy unless z.nil?
      else
        g = Genre.find_by_id s.genre_id
        s.update_attribute(:genre_name, g.name)
      end

      flash[:success] = "The song: \"#{@song.title.upcase}\" was successfully created"
      redirect_to songs_path
    else
      render 'new'
    end
  end

  def destroy
    title = Song.find(params[:id]).title
    Song.find(params[:id]).destroy
    flash[:alert] = "The song: \"#{title.upcase}\" was successfully destroyed"
    redirect_to :back
  end

  def trackers
    @title = "Trackers"
    @song = Song.find(params[:id])
    @setlists = @song.trackers.paginate(per_page: 10, page: params[:page])
    render 'show'
  end
  
# 
  private

  def prepare_albums
    @albums = Album.all
  end

  def prepare_composers
    @composers = Composer.all
  end

  def prepare_genres
    @genres = Genre.all
  end

end
