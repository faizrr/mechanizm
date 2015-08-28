class Event < ActiveRecord::Base
  belongs_to :user
  validates :title, :start_datetime, :end_datetime, presence: true
  validates :start_datetime, :end_datetime, :overlap => {:scope => "user_id"}
end
