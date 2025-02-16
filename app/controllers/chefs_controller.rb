class ChefsController < ApplicationController

 before_action :set_chef, only: [:show, :edit, :update, :destroy]


def index 
 @chefs = Chef.paginate(page: params[:page], per_page: 3)



end
def new 
	@chef = Chef.new
end 

def create 

  @chef= Chef.new(chef_params)
  if @chef.save
    session[:chef_id] = @chef.id
  	flash[:success] = "Welcome #{@chef.chefname} to my recipes app"
  	redirect_to chef_path(@chef)
  else
  	render 'new', status: :unprocessable_entity
  end

end

def show
 
 @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
end	

def edit

end

def update
   if @chef.update(chef_params)
   	flash[:success] = "Updated Sccessfully"
   	redirect_to @chef
   else
   	render 'edit',status: :unprocessable_entity
   end

end

def destroy
 
  @chef.destroy
  flash[:danger] = "Chef and all associated recipes have been deleted"
  redirect_to chefs_path
end




private 
  
  def chef_params
  	params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef

    @chef = Chef.find(params[:id])
  end

end