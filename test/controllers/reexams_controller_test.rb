require "test_helper"

class ReexamsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reexams_new_url
    assert_response :success
  end

  test "should get create" do
    get reexams_create_url
    assert_response :success
  end

  test "should get index" do
    get reexams_index_url
    assert_response :success
  end
end
