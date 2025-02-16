class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_some_user, only: [:edit, :update, :destroy]
	def index
		@recipes = Recipe.paginate(page: params[:page], per_page: 3)
	end

  def new
   
       @recipe = Recipe.new
       Rails.logger.debug "Initialized @recipe: #{@recipe.inspect}"

	end


  def show

   
	end

	def create 
    
     @recipe = Recipe.new(recipe_params)
     @recipe.chef = current_chef
     if @recipe.save
     	flash[:success] = "Recipe is created successfully"
     	redirect_to recipe_path(@recipe)

     else
       render 'new', status: :unprocessable_entity
     end	
    end


    def edit
    

    end

  def update


    if @recipe.update(recipe_params)
      flash[:success] = "Recipe is updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
end




    

	def destroy
   # binding.pry
	  Recipe.find(params[:id]).destroy
	  flash[:success] = "Recipe deleted successfully"
	  redirect_to recipes_path
	end



	private
  def set_recipe
     @recipe = Recipe.find(params[:id])
  end

	def recipe_params
     
      params.require(:recipe).permit(:name ,:description)


    end

  def require_some_user
    if current_chef != @recipe.chef
      flash[:danger] = "you can only set your own recipe"
      redirect_to recipes_path

    end
  end
	


end