# frozen_string_literal: true
class StandupsController < ApplicationController
  def show
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all_for_today
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = Time.zone.today.friday?
  end

  def present
    @backmakers = Backmaker.all
    @next_week_mc = choose_random_backmaker if Time.zone.today.friday?

    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all_for_today
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = Time.zone.today.friday?
  end

  def update
    tomorrow = Standup.new(date_of: Date.tomorrow)
    tomorrow.save

    redirect_to action: 'show', id: 'today'
  end

  private
  def choose_random_backmaker
    @backmakers.sample.name
  end
end
