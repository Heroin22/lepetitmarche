require 'test_helper'

class AdControllerTest < ActionController::TestCase
  test "should get listAd" do
    get :listAd
    assert_response :success
  end

  test "should get newAd" do
    get :newAd
    assert_response :success
  end

  test "should get findAd" do
    get :findAd
    assert_response :success
  end

  test "should get modifyAd" do
    get :modifyAd
    assert_response :success
  end

  test "should get deleteAd" do
    get :deleteAd
    assert_response :success
  end

end
