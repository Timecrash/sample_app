require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:matt)
  end
  
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', test: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    #Test for stats
    assert_select 'strong', @user.following.count
    assert_select 'a[href=?]', following_user_path(@user)
    assert_select 'strong', @user.followers.count
    assert_select 'a[href=?]', followers_user_path(@user)
  end
end
