# frozen_string_literal: true
class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event =
      Event.new(
        title: params.require(:event).require(:title),
        date: date_from_params
      )

    @event.save

    redirect_to '/standups/today'
  end

  private

  def date_from_params
    Date.civil(
      params.require(:event)['date(1i)'].to_i,
      params.require(:event)['date(2i)'].to_i,
      params.require(:event)['date(3i)'].to_i
    )
  end
end
