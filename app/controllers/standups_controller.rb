# frozen_string_literal: true
class StandupsController < ApplicationController
  def show
    @interestings = Interesting.where(standup: Standup.last)
  end
end
