class ZombiesControllerTest < ActionController::TestCase
  require "test_helper"

  setup do
    @request.headers["Accept"] = Mime::json
    @request.headers["Content-Type"] = Mime::JSON.to_s
  end

  test "should post my action" do
    post :my_action, { "retailer": "Target",
                       "purchaseDate": "2022-01-01",
                       "purchaseTime": "13:01",
                       "items": [
           {
             "shortDescription": "Mountain Dew 12PK",
             "price": "6.49",
           }, {
             "shortDescription": "Emils Cheese Pizza",
             "price": "12.25",
           }, {
             "shortDescription": "Knorr Creamy Chicken",
             "price": "1.26",
           }, {
             "shortDescription": "Doritos Nacho Cheese",
             "price": "3.35",
           }, {
             "shortDescription": "Klarbrunn 12PK 12 FL OZ",
             "price": "12.00",
           },
         ],
                       "total": "35.35" }, :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "Some returned value", body["str"]
  end
end
