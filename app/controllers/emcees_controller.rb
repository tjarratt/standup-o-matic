# frozen_string_literal: true
class EmceesController < ApplicationController
  def index
    @mc = Backmaker.find(Sprint.last.backmaker_id)
    @backmakers = Backmaker.all - [@mc]
  end

  def update
   new_mc = Backmaker.find(params.require('backmaker_id'))
   sprint = Sprint.last_or_create
   sprint.backmaker_id = new_mc.id
   sprint.save

   redirect_to emcees_path
  end
end
