class StandupsController < ApplicationController
  def show
    @interestings = Interesting.where(standup: Standup.last)
  end
end
