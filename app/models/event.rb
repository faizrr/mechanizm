class Event < ActiveRecord::Base
  belongs_to :user
  validates :title, :start_datetime, :end_datetime, presence: true
  validates :start_datetime, :end_datetime, :overlap => {:scope => "user_id"}
  validate :start_before_end

  private
    def start_before_end
      errors.add(:start_datetime, "must be before end datetime") unless
          start_datetime < end_datetime
    end

end
