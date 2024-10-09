require "test_helper"

class SharedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shareds_index_url
    assert_response :success
  end
end
