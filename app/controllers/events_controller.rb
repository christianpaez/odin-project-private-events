class EventsController < ApplicationController
  before_action :current_user
  before_action :set_event, only: [:add_attendant, :remove_attendant]
  def index
    @upcoming_events = Event.upcoming_events
    @previous_events = Event.previous_events
  end

  def new
    @event = @current_user.events.build
    puts @event
  end

  def create
    @event = @current_user.events.build
    @event.description = event_params[:description]
    @event.location = event_params[:location]
    @event.date = event_params[:date]
    if @event.save(event_params)
      redirect_to users_path, flash: { notice: "Event Created!" }
    else
      redirect_to new_event_user_path(@current_user), flash: { alert: "Cannot Save Event, please try again"}
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def add_attendant
    if @event.attendes.push(@current_user)
      redirect_to event_path(@event), flash: { info: "Attende Added!"}
    else
      redirect_to event_path(@event), flash: { warning: "Cannot add attende!"}
    end
  end

  def remove_attendant
    if @event.attendes.delete(@current_user.id)
      redirect_to event_path(@event), flash: { info: "Attende removed!"}
    else
      redirect_to event_path(@event), flash: { warning: "Cannot remove attende!"}
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:description, :location, :date)
  end
end
