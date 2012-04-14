require "pwinty/version"
require 'weary'

module Pwinty

  class Client < Weary::Client
    domain "https://sandbox.pwinty.com"

    headers "X-Pwinty-MerchantId" => ENV['PWINTY_MERCHANT_ID'],
    			  "X-Pwinty-REST-API-Key" => ENV['PWINTY_API_KEY']

    post :orders, "/Orders" do |resource|
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
