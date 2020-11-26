require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cur_user = User.create(name: "Example User", email: "user@example.com",
                            password: 'testPassword',
                            password_confirmation: 'testPassword')
  end

  test "should get show" do
    get "/users/#{@cur_user.id}"
    assert_response :success
  end

  test "should not have debug infos" do
    get "/users/#{@cur_user.id}"
    assert_select "body pre", 0
  end

  test "should have profile photo" do
    get "/users/#{@cur_user.id}"
    assert_select "img", alt: @cur_user.name, class: "gravatar"
  end

  test "should match cur user" do
    get "/users/#{@cur_user.id}"
    assert_select "h1", text: @cur_user.name
  end

  test "/users/new should have name text field" do
    get "/users/new"
    assert_select "input#user_name", 1
  end

  test "/users/new should have email text field" do
    get "/users/new"
    assert_select "input#user_email", 1
  end

  test "/users/new should have password text field" do
    get "/users/new"
    assert_select "input#user_password", 1
  end

  test "/users/new should have password confirmation text field" do
    get "/users/new"
    assert_select "input#user_password_confirmation", 1
  end

  test "/users/new should have submit button" do
    get "/users/new"
    assert_select "input[name=commit]", value: "创建账户"
  end

end
