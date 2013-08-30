class GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    # @selected_genre = Genre.find(params[:id])

    @songs = @genre.songs.paginate(per_page: 10, page: params[:page])

  end

end
