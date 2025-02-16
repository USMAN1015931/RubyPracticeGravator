require "test_helper"

class ChefsSignupTest < ActionDispatch::IntegrationTest




  test "reject an invalid signup" do
    get chefs_signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: { chefname: " ", 
                                 email: " ", password: "password",
                                    password_confirmation: " " } }
    end
    assert_template 'chefs/new'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end
  
  test "accept valid signup" do
    get chefs_signup_path
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: { chefname: "mashrur", 
                email: "mashrur@example.com", password: "password",
                              password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
