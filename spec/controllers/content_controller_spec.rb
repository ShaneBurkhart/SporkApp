require 'spec_helper'

describe ContentController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @user.add_role :basic# gives the user a role. tests pass regardless of role
  end

  describe "GET 'content'" do
    it "returns http success" do
      get 'content'
      response.should @user.has_role?(:basic) ? be_success : redirect_to(root_url)
    end
  end
end
