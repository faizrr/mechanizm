require 'rails_helper'

describe WelcomeController do
  it 'should render welcome page if user not signed in' do
    get :index
    expect(response).to render_template 'index'
  end

  it 'should redirect to calendar page if user signed in' do
    sign_in FactoryGirl.create(:user)
    get :index
    expect(response).to redirect_to(calendar_path)
  end
end