require 'rails_helper'

describe 'Event' do

  it "is has valid factory" do
    f = FactoryGirl.create(:event)
    expect(f).to be_valid
  end

  it "is invalid when event's start_time more than end_time" do
    f = FactoryGirl.create(:event)
    f.start_datetime = Time.new(2015,1,1,0,0,0)+1.hours
    f.end_datetime = Time.new(2015,1,1,0,0,0)
    expect(f).not_to be_valid
  end

  it "should not be valid if event1 time overlap event2 time" do
    f1 = FactoryGirl.create(:event,
                            start_datetime:Time.new(2015,1,1,0,0,0),
                            end_datetime: Time.new(2015,1,1,0,0,0)+3.hours)

    expect {
      f2 = FactoryGirl.create(:event,
                              start_datetime: Time.new(2015,1,1,0,0,0)+1.hours,
                              end_datetime: Time.new(2015,1,1,0,0,0)+3.hours)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

end