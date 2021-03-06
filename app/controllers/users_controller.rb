class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]

  def index
    @users = User.order('id ASC')
    rescue ActiveRecord::NoMethodError
        redirect_to '/home'
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
      flash[:success] = "Welcome to the Promorpheus PROTOTYPE"
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

  def destroy
    user = User.find(params[:id])
    username = User.find(params[:id]).name
    if user != current_user
      User.find(params[:id]).destroy
      flash[:alert] = "The user: \"#{username.upcase}\" was successfully removed"
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      redirect_to signin_url
    end
  end

  private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
    end

end
