class AlbumsController < ApplicationController

  def show
    @album = Album.find(params[:id])
    # @selected_album = Album.find(params[:id])

    @songs = @album.songs.paginate(per_page: 10, page: params[:page])
  end

end
