require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def setup
    @chef = Chef.create!(chefname: "Usman ali",email: "usman18224@gmail.com")
    @recipe = Recipe.create!(name: "chciken quorma", description:"Desi Khana", chef:@chef)
    @recipe2 = @chef.recipes.build(name:"chciken kria", description:"chiken made in desi oil ")
    @recipe2.save
   end


  test "should get recipes index" do
   get recipes_url
   assert_response :success
  end

  test "should list all recipes" do
  get recipes_path
  assert_template 'recipes/index'
  assert_match @recipe.name, response.body
  assert_match @recipe2.name, response.body

  end


end
