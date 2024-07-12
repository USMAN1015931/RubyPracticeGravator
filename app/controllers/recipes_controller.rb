class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

    def new
   
       @recipe = Recipe.new
       Rails.logger.debug "Initialized @recipe: #{@recipe.inspect}"

	end


    def show

   	  @recipe = Recipe.find(params[:id])
	end

	def create 
    
     @recipe = Recipe.new(recipe_params)
     @recipe.chef = Chef.first
     if @recipe.save
     	flash[:success] = "Recipe is created successfully"
     	redirect_to recipe_path(@recipe)

     else
       render 'new', status: :unprocessable_entity
     end	
    end


    def edit
    @recipe = Recipe.find(params[:id])

    end

    def update

     @recipe = Recipe.find(params[:id])	

     if @recipe = Recipe.update(recipe_params)
       flash[:success]  = "Recipe is updated successfully"
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


	def recipe_params
     
      params.require(:recipe).permit(:name ,:description)


    end
	


end