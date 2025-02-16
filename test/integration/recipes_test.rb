require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def setup
    @chef = Chef.create!(chefname: "Usman ali",email: "usman18224@gmail.com", password:"password", password_confirmation:"password")
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

  test "should get recipes show" do
    sign_in_as(@chef,"password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_select 'a[href=?]', recipes_path, text: "Return to recipes listing"

  end


  test "should get recipes listing" do
  get recipes_path
  assert_template 'recipes/index'
  assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  

  test "create new valid recipe" do
    sign_in_as(@chef, "password")

    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicken, add vegetables, 

                       cook for 20 minutes, serve delicious meal"
    assert_difference 'Recipe.count', 1 do
    post recipes_path, params: { recipe: { name: name_of_recipe, 

               description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
  

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end


end
