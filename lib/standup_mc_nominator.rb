# frozen_string_literal: true

class StandupMCNominator
  def initialize(backmakers)
    @backmakers = backmakers
  end

  def choose_one
    @backmakers.sample
  end
end

