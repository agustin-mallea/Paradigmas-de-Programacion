require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get list_trips" do
    get trips_list_trips_url
    assert_response :success
  end

  test "should get available_trips" do
    get trips_available_trips_url
    assert_response :success
  end

end
