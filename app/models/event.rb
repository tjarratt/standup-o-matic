# frozen_string_literal: true
class Event < ApplicationRecord
  has_many :standups, dependent: :nullify
end
