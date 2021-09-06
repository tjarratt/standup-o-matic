# frozen_string_literal: true
class InterestingsController < ApplicationController
  def new
    @interesting = Interesting.new
  end

  def create
    @interesting =
      Interesting.new(
        title: params.require(:title),
        body: params.require(:body),
        standup: Standup.last
      )
    @interesting.save

    redirect_to '/standups/today'
  end

  private

  def safe_params
    params.require([:title, :body])
  end
end
