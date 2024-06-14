require "test_helper"

class RenewalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get renewals_new_url
    assert_response :success
  end

  test "should get create" do
    get renewals_create_url
    assert_response :success
  end
end
