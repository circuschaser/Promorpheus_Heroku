class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]

  def index
    @users = User.order('id ASC')
  end

	def show
		@user = User.find(params[:id])
	end
	
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to AmateurMorpheus"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # def last_set_activity
  #   @user.setlists.each do |set|
  #     x = []
  #     set.tracks.order("updated_at DESC")
  #     t = set.tracks.first
  #     x << t

  private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
    end

end
