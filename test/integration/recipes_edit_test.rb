require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Usman ali",email: "usman18224@gmail.com", password:"password", password_confirmation:"password")
    @recipe = Recipe.create!(name: "chciken quorma", description:"Desi Khana", chef:@chef)


   end


  test "reject invalid recipe update" do
  get edit_recipe_path(@recipe)
  assert_template 'recipes/edit'
  patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } } 
  assert_template 'recipes/edit'
  assert_select 'h2.card-title', text: 'Edit Recipe'
  assert_select 'div.card-body'
  end

    test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe),params: { recipe: { name: updated_name,  description: updated_description } }
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

end
