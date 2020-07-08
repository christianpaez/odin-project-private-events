class EventsController < ApplicationController
  before_action :current_user
  def index
    @events = Event.all
  end

  def new
    @event = @current_user.events.build
    puts @event
  end

  def create
    @event = @current_user.events.build
    @event.description = event_params[:description]
    puts @event.description
    puts
    if @event.save(event_params)
      redirect_to users_path, flash: { notice: "Event Created!" }
    else
      redirect_to new_event_user_path(@current_user), flash: { alert: "Cannot Save Event, please try again"}
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:description)
  end
end
