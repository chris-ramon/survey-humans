require 'spec_helper'

describe FrontController do

  describe "GET 'sign_up'" do
    it "returns http success" do
      get 'sign_up'
      response.should be_success
    end
  end

end
