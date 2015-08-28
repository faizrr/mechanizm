class EventsController < ApplicationController
  respond_to :json

  def index
    redirect_to calendar_path
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    range = (@event.start_datetime..@event.end_datetime)


    if @event.save
      redirect_to calendar_path
    else
      render 'new'
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :end_datetime)
    end
end
