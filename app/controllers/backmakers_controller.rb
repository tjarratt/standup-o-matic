# frozen_string_literal: true
class BackmakersController < ApplicationController
  def index
    @backmakers = Backmaker.all
  end

  def new
    @backmaker = Backmaker.new
  end

  def create
    @backmaker = Backmaker.new(safe_params)
    if @backmaker.save
      flash[:notice] = "Let's welcome #{safe_params[:name]} to the team"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  private

  def safe_params
    params.require(:backmaker).permit(:name)
  end
end
