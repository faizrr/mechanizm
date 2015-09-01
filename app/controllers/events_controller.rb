class EventsController < ApplicationController
  respond_to :json

  def index
    from_time = params[:from]
    to_time = params[:to]

    # if from_time > to_time will be later

    if from_time.blank? or to_time.blank?
      @events = current_user.events.all
    else
      @events = current_user.events.where("start_datetime >= ? AND end_datetime <= ?", Time.at(from_time.to_i), Time.at(to_time.to_i))
    end

    respond_to do |f|
      f.json
    end
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to calendar_path
    else
      render 'new'
    end
  end

  def destroy
    # check user_id with current_user
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :end_datetime)
    end
end
