class ApplicationController < ActionController::Base
   helper_method :current_chef, :logged_in?

 def current_chef
  @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
 end



 def logged_in?
  !!current_chef
 end

def require_user
 if !logged_in?
 	flash[:danger] = "first to loggin to perform such action"
 	redirect_to root_path
 end

end
end
