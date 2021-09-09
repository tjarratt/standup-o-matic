# frozen_string_literal: true
class MomentOfZenController < ApplicationController
  def new
    @moment_of_zen = MomentOfZen.new
  end

  def create
    @moment_of_zen =
      MomentOfZen.new(
        title: params.require(:title),
        body: params.require(:body),
        standup: Standup.last
      )
    @moment_of_zen.save

    redirect_to '/standups/today'
  end
end
