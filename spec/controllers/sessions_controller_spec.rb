require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    action { get :new }
    it { should respond_with :success }
    specify { assigns(:session).should_not be_nil }
  end

  describe "POST 'create'" do
    before { @user = FactoryGirl.create :user, :password => 'password', :username => 'bob' }
    action { post :create, :user_session => { :username => 'bob', :password => pass } }

    context 'with correct username and password' do
      let(:pass) { 'password' }
      it { should redirect_to root_url }
      specify { assigns(:user).should == @user }
      specify { flash[:success].should match /successfully signed in/i}
    end

    context 'with incorrect username and password' do
      let(:pass) { 'incorrect password' }
      specify { assigns(:user).should be_nil }
      it { should render_template :new }
      specify { flash[:alert].should match /Incorrect password or username!/i }
    end
  end

  describe "DELETE 'destroy'" do
    before { @user = FactoryGirl.create :user, :password => 'password', :username => 'bob' }
    before { login_user @user }
    action { delete :destroy }

    specify { flash[:success].should match /successfully signed out/i}
    it { should redirect_to root_url }
    # specify { controller.current_user.should be_nil }
  end
end
