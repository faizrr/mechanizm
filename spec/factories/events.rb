FactoryGirl.define do
  factory :event do
    sequence (:start_datetime) { |i| Time.new(2015,1,1,0,0,0)+i.hours }
    sequence (:end_datetime) { |i| Time.new(2015,1,1,0,0,0)+1.hours+i.hours }
    user_id 1
    title "Test"
  end
end