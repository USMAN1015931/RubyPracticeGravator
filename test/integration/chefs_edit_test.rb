require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  

  def setup
   @chef = Chef.create!(chefname: "mashrur", 
                      email: "mashrur@example.com",
                          password: "password", 
                          password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", 
                              email: "mashrur@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end
  
  test "accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "mashrur1", 
                                email: "mashrur1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur1", @chef.chefname
    assert_match "mashrur1@example.com", @chef.email
  end
end
