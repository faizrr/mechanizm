require 'rails_helper'

describe EventsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'JSON' do
    render_views

    it 'should follow bootstrap-calendar format' do
      events = []
      for i in 0..2
        events << FactoryGirl.create(:event,user_id: @user.id)
      end

      get :index, format: 'json'

      json = JSON.parse(response.body)

      expect(json['success']).to eq(1)
      expect(json['result'].size).to eq(3)
      for i in 0..2
        #checking existence with equality
        expect(json['result'][i]['id']).to eq(events[i].id)
        expect(json['result'][i]['title']).to eq(events[i].title)
        expect(json['result'][i]['start']).to eq(events[i].start_datetime.to_i*1000)
        expect(json['result'][i]['end']).to eq(events[i].end_datetime.to_i*1000)
      end
    end

    it 'should return 2 elements in range' do
      events = []
      for i in 0..2
        events << FactoryGirl.create(:event,user_id: @user.id)
      end

      get :index, format: 'json', from: events[0].start_datetime.to_i*1000, end: events[1].start_datetime.to_i*1000
    end
  end

  describe 'for authenticated users' do
    describe 'action new' do
      it 'should render \'new\' template' do
        get :new
        expect(response).to render_template('new')
      end
    end

    describe 'action edit' do
      it 'should redirect to root path if event not belongs to user' do
        event = FactoryGirl.create(:event,user_id:0)
        get :edit, { id: event.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'action delete' do
      it 'should not delete if event not belongs to user' do
        expect {
          event = FactoryGirl.create(:event,user_id:0)
          delete :destroy, { id: event.id }
        }.to change(Event, :count).by(1) # adds the event, but not deletes
      end
    end

  end
end