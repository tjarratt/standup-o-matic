# frozen_string_literal: true
class StandupsController < ApplicationController
  def show
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
  end

  def present
    @backmakers = Backmaker.all
    @interestings = Interesting.where(standup: Standup.last)
  end
end
