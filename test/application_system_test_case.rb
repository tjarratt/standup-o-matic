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

  def visit_safely(url)
    visit url
    assert_no_js_errors
  end

  def assert_no_js_errors
    errors =
      page
        .driver
        .browser
        .manage
        .logs
        .get(:browser)
        .reject { |e| e.level == 'WARNING' }

    assert errors.length.zero?,
           "Expected no js errors, but these errors where found: #{errors.join(', ')}"
  end
end
