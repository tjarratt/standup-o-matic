# frozen_string_literal: true

require 'standup_emcee_nominator'

class StandupsController < ApplicationController
  attr_reader :next_week_mc

  def initialize(nominator: StandupEmceeNominator.new)
    @nominator = nominator
    super()
  end

  def show
    @sprint = Sprint.last_or_create
    @mc = current_mc if @sprint
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all_for_today
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = ready_for_zen
  end

  def present
    @sprint = Sprint.last_or_create
    @mc = current_mc if @sprint
    @backmakers = Backmaker.all
    @next_week_mc = choose_random_backmaker if Time.zone.today.friday?

    @interestings = Interesting.where(standup: Standup.last)
    @events = Event.all_for_today
    @moment_of_zen = MomentOfZen.where(standup: Standup.last).first
    @has_moment_of_zen = ready_for_zen
  end

  def nominate
    next_weeks_mc = Backmaker.where(name: params.require('backmaker')).first
    Sprint.create(backmaker_id: next_weeks_mc.id)
  end

  def update
    Standup.create(date_of: Time.zone.today)

    redirect_to action: 'show', id: 'today'
  end

  private

  def current_mc
    Backmaker.find(@sprint.backmaker_id)
  end

  def choose_random_backmaker
    eligible_backmakers = @backmakers - [@mc]
    backmaker = @nominator.choose_one(eligible_backmakers)
    backmaker.name
  end

  def ready_for_zen
    (
      Time.zone.today.friday? &&
        Standup.where(date_of: Time.zone.today).count.zero?
    ) ||
      (
        Time.zone.today.thursday? &&
          Standup.where(date_of: Time.zone.today).count.positive?
      )
  end
end
