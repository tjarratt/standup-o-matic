# frozen_string_literal: true
class Standup < ApplicationRecord
  has_many :interestings, dependent: :destroy
  has_many :events, dependent: :destroy

  has_one :moment_of_zen, dependent: :destroy
end
