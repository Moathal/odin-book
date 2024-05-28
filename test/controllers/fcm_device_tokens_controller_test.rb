require "test_helper"

class FcmDeviceTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get fcm_device_tokens_create_url
    assert_response :success
  end

  test "should get destroy" do
    get fcm_device_tokens_destroy_url
    assert_response :success
  end
end
