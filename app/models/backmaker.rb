# frozen_string_literal: true
class Backmaker < ApplicationRecord
  has_many :sprints, dependent: :nullify
end
