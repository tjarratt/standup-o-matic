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

  def click_on_safely(selector)
    click_on(selector)
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

  def add_backmaker(name)
    visit_safely backmakers_path

    click_on_safely 'Add new BackMaker'
    fill_in 'Name', with: name
    click_on_safely 'Save'

    assert_text name
  end

  def add_backmakers(*names)
    names.each { |name| add_backmaker(name) }
  end

  def add_interesting(title, body)
    visit_safely '/standups/today'

    click_on_safely 'Add new Interesting'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on_safely 'Save'

    assert_selector 'ul.interestings', text: title
  end

  def add_event(title, year, month, day)
    visit_safely '/standups/today'

    click_on_safely 'Add new Event'
    fill_in 'Title', with: title
    select year, from: 'event_date_1i'
    select month, from: 'event_date_2i'
    select day, from: 'event_date_3i'

    click_on_safely 'Save'
  end

  def add_moment_of_zen(title, body)
    visit_safely '/standups/today'

    click_on_safely 'Add Moment of Zen'
    fill_in 'Title', with: title
    fill_in 'Body', with: body

    click_on_safely 'Save'
  end
end
