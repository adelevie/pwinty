require "pwinty/version"
require "weary"
require "active_attr"

module Pwinty

  def self.client
    @@client ||= Pwinty::Client.new
    @@client
  end

  class Order
  end

  class Photo
  end

  class Client < Weary::Client
    domain "https://sandbox.pwinty.com"

    headers "X-Pwinty-MerchantId" => ENV['PWINTY_MERCHANT_ID'],
    			  "X-Pwinty-REST-API-Key" => ENV['PWINTY_API_KEY']

    post :create_order, "/Orders" do |resource|
      resource.required :recipientName, :address1, :addressTownOrCity, 
                        :stateOrCounty, :postalOrZipCode, :country
    end

    get :get_submission_status, "/Orders/SubmissionStatus" do |resource|
      resource.required :id
    end

    post :set_submission_status, "/Orders/Status" do |resource|
      resource.required :status, :orderId
    end

    post :add_photo, "/Photos" do |resource|
      resource.required :orderId, :type, :copies, :sizing
      resource.optional :file, :url
    end
  end
end
