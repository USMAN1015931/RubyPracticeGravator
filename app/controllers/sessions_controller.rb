class SessionsController < ApplicationController


 def new
 end


 def create
   chef = Chef.find_by(email: params[:sessions][:email].downcase)
   if chef && chef.authenticate(params[:sessions][:password])
	  session[:chef_id] = chef.id
      flash[:success] = "You have successfully logged in"
      redirect_to chef

   else
	 	flash.now[:danger] = "There is something wrong with your login"
	 	render 'new', status: :unprocessable_entity
   end



 end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end


end

