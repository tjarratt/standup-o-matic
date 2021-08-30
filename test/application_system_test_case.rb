# frozen_string_literal: true
require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def self.options
    if ENV['CI']
      { args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage] }
    else
      {}
    end
  end

  driven_by :selenium,
            using: :chrome,
            options: options,
            screen_size: [1400, 1400]
end
