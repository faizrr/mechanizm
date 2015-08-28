class EventsController < ApplicationController
  respond_to :json

  def index
    @events = current_user.events.all
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
