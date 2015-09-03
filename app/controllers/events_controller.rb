class EventsController < ApplicationController
  respond_to :json
  before_action :setEvent, only: [:edit,:update,:destroy]

  def index
    from_time = params[:from]
    to_time = params[:to]

    # if from_time > to_time will be later

    if from_time.blank? or to_time.blank?
      @events = current_user.events.all
    else
      from_time = from_time[0..-4]
      to_time = to_time[0..-4]
      @events = current_user.events.where("start_datetime >= ? AND end_datetime <= ?", Time.at(from_time.to_i), Time.at(to_time.to_i))
    end

    respond_to do |f|
      f.json
    end
  end

  def new
    @event = current_user.events.build
  end

  def edit

  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to calendar_path
    else
      render 'new'
    end
  end

  def update
    if @event.update(event_params)
      redirect_to calendar_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to calendar_path
  end

  private
    def setEvent
      @event = Event.find(params[:id])
      authorize @event, :owned?
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :end_datetime)
    end
end
