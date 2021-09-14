# frozen_string_literal: true
class Sprint < ApplicationRecord
  has_one :backmaker, dependent: :nullify

  def self.last_or_create
    return last unless last.nil?

    backmakers = Backmaker.all
    return nil if backmakers.empty?

    create(backmaker_id: backmakers.sample.id)
  end
end
