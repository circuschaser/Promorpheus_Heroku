class ComposersController < ApplicationController

  def show
    @composer = Composer.find(params[:id])
    # @selected_composer = Composer.find(params[:id])

    @songs = @composer.songs.paginate(per_page: 10, page: params[:page])

  end

end
