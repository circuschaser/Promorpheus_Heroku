class SessionsController < ApplicationController

	def new
		if signed_in?
			redirect_to "/home"
		end
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# Sign the user in, redirect to main page
			sign_in user
			redirect_to "/home"
		else
			# create an error message and re-render signin form
			flash.now[:error] = "Sorry. We couldn't find an account with that info."
			render "new"
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
