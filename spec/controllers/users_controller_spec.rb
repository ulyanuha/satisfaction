require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    let(:attributes) { FactoryGirl.attributes_for(:user) }
    let(:user) { double('user') }

    action { post :create, :user => attributes }
    before { User.stub(:new => user) }

    context 'when successful' do
      before { user.stub(:save => true) }
      it { should redirect_to root_url }
    end

    context 'when failure' do
      before { user.stub(:save => false) }
      it { should render_template :new }
    end
  end 

end
