require "test_helper"

class TestClient < Test::Unit::TestCase

  def setup
    @params = {
      :recipientName => "FirstName LastName",
      :address1 => "123 Anywhere Street",
      :addressTownOrCity => "San Francisco",
      :stateOrCounty => "CA",
      :postalOrZipCode => "94101",
      :country => "USA"
    }
  end

  def test_initialize
    c = Pwinty::Client.new
    request = c.create_order(@params)
    assert_equal request.class, Weary::Request
  end

  def test_headers
    c = Pwinty::Client.new
    request = c.create_order(@params)
    resp = request.perform
    assert_equal request.class, Weary::Request
    assert_equal resp.class, Weary::Response
    assert_equal request.headers["X-Pwinty-MerchantId"].class, String
    assert_equal request.headers["X-Pwinty-REST-API-Key"].class, String
  end

  def test_orders_integration
    # initialize client
    c = Pwinty::Client.new

    # create Order
    request = c.create_order(@params)
    response = request.perform
    body = JSON.parse(response.body)
    keys = %w[ id recipientName
               address1 address2
               addressTownOrCity
               stateOrCounty textOnReverse
               postalOrZipCode
               country status photos ]
    assert_equal body.keys.sort!, keys.sort!
    id = body["id"]
    puts body.inspect

    # add Photo to Order
    request = c.add_photo(:orderId => id,   
                          :type => "4x6", :url => "http://i.imgur.com/xXnrL.jpg", :copies => 1, :sizing => "ShrinkToFit")
    response = request.perform
    body = JSON.parse(response.body)
    puts body.inspect

    # set Order SubmissionStatus
    request = c.get_submission_status(:id => id)
    response = request.perform
    body = JSON.parse(response.body)
    keys = %w[id isValid generalErrors photos]
    if body["error"]
      assert body["error"].class, String
    else                 
      assert_equal body.keys.sort!, keys.sort!
    end
    puts body.inspect

    # submit Order
    request = c.set_submission_status(:orderId => id, :status => "Submitted")
    response = request.perform
    body = JSON.parse(response.body)
    puts body.inspect
  end

end
