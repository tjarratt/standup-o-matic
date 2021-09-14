# frozen_string_literal: true
class StandupsController < ApplicationController
  def show
    @mc = Backmaker.find(@sprint.backmaker_id) if (
      @sprint = Sprint.last_or_create
    )

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

  def nominate
    next_weeks_mc = Backmaker.where(name: params.require('backmaker')).first
    Sprint.create(backmaker_id: next_weeks_mc.id)
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
