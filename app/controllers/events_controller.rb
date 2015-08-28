class EventsController < ApplicationController
  def new
    @event = current_user.posts.build
  end

  def create
    @event = current_user.posts.build(event_params)
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :end_datetime)
    end
end
