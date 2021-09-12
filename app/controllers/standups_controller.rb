# frozen_string_literal: true
class StandupsController < ApplicationController
  def show
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = Time.zone.today.friday?
  end

  def present
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = Time.zone.today.friday?
  end

  def update
    tomorrow = Standup.new(date_of: Date.tomorrow)
    tomorrow.save

    redirect_to action: 'show', id: 'today'
  end
end
