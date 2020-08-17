require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get items_top_url
    assert_response :success
  end

end
