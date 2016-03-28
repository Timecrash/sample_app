require 'test_helper'

class UsersActivationTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matt)
    @unactivated = users(:burt)
  end
  
  test "unactivated users do not appear in index" do
    log_in_as(@user)
    get users_url
    assert_select "a[href=?]", user_path(@unactivated), count: 0
  end
  
  test "unactivated users profiles do not display" do
    log_in_as(@user)
    get user_url(@unactivated)
    assert_redirected_to root_url
  end
end
