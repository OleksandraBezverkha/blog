class EventsController < ApplicationController

  def index
     @events=Event.all.page(params[:page]).per(10)
  end

end