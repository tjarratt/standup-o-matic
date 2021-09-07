# frozen_string_literal: true
class Standup < ApplicationRecord
  has_many :interestings, dependent: :destroy
end
