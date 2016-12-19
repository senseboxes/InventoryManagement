require 'test_helper'

class MonthaverageControllerTest < ActionDispatch::IntegrationTest
  test "should get yearavg" do
    get monthaverage_yearavg_url
    assert_response :success
  end

  test "should get monthavg" do
    get monthaverage_monthavg_url
    assert_response :success
  end

  test "should get dailyavg" do
    get monthaverage_dailyavg_url
    assert_response :success
  end

end
