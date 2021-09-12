# frozen_string_literal: true
class Event < ApplicationRecord
  has_many :standups, dependent: :nullify

  def self.all_for_today
    where('date > ?', Date.yesterday)
  end
end
