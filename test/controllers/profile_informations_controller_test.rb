require "test_helper"

class ProfileInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get profile_informations_new_url
    assert_response :success
  end
end
