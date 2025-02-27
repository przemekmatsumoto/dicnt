require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should get dashboard" do

    get dashboard_url
    assert_response :success
    assert_select "h1", "Twój Dashboard"
  end

  private
  def sign_in(user)
    post session_url, params: { email_address: 'one@example.com', password: "password" }
  end
end