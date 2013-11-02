class ComposersController < ApplicationController

  def show
    @composer = Composer.find(params[:id])
    # @selected_composer = Composer.find(params[:id])
    @songs = @composer.songs.paginate(per_page: 10, page: params[:page])
  end

  def index
    @composers = Composer.search(params[:search]).paginate(per_page: 10, page: params[:page])
    
    respond_to do |format|  
      format.html # index.html.erb  
      format.json { render json: @composers }
    end
  end

end
