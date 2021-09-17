# frozen_string_literal: true
require 'application_system_test_case'

class StandupsTest < ApplicationSystemTestCase
  include ActiveSupport::Testing::TimeHelpers

  test 'presenting standup for an average day' do
    add_backmakers('Alice', 'Bob')
    add_interesting(
      'Banana poisoning',
      'Eating 10 million bananas at once would kill you'
    )
    add_event('Retrospective', '2026', 'January', '31')

    assert_selector 'ul.events', text: 'Retrospective'
    assert_selector 'p.zen', count: 0

    click_on 'Allez let\'s go'
    assert_no_js_errors

    assert_selector 'section#interestings', text: "Interestings\n1"
    assert_selector 'section#backmakers', text: "La Team\n2"
    assert_selector 'section#events', text: "Events\n1"
    assert_selector '.spotlight'

    find('section#interestings').click
    assert_selector '.spotlight', text: /Banana poisoning/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Alice\nBob/
    assert_no_text 'Banana poisoning'

    find('section#events').click
    assert_selector '.spotlight', text: /Retrospective : 2026-01-31/
    assert_no_js_errors
  end

  test 'preparing for a jolly moment of zen on Thursday' do
    travel_to Date.parse('thursday')

    add_backmakers('Alice', 'Bob')
    visit_safely '/standups/today'
    assert_selector 'section#zen', count: 0

    click_on 'Allez let\'s go'
    click_on 'Standup is DONE'

    assert_selector 'section#zen'
  end

  test 'presenting standup on Friday' do
    friday = Date.parse('friday')
    travel_to friday

    add_backmakers('Alice', 'Bob', 'Carol', 'David')
    add_moment_of_zen('Typical moment of zen', 'http://example.com')
    assert_selector 'p.zen', text: 'All good on zen for now ...'

    click_on 'Allez let\'s go'
    assert_no_js_errors

    assert_selector 'section#zen'
    assert_selector '.spotlight'

    find('section#zen').click
    assert_selector '.spotlight', text: /Typical moment of zen/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Next week's MC will be .../, count: 0

    find('.spotlight li', text: 'Alice').click
    find('.spotlight li', text: 'Bob').click
    find('.spotlight li', text: 'Carol').click
    find('.spotlight li', text: 'David').click

    assert_selector '.spotlight', text: /Next week's MC will be .../

    select 'Alice', from: 'nextMC'
    click_on 'Make it so'
    click_on 'Standup is DONE'

    assert_selector 'section#zen', count: 0

    travel_to friday + 3
    visit_safely '/standups/today'

    assert_selector 'h4', text: 'Your MC this week will be ... Alice'
    assert_no_js_errors
  end

  def add_backmaker(name)
    visit_safely backmakers_path

    click_on 'Add new BackMaker'
    fill_in 'Name', with: name
    click_on 'Save'

    assert_text name
  end

  def add_backmakers(*names)
    names.each { |name| add_backmaker(name) }
  end

  def add_interesting(title, body)
    visit_safely '/standups/today'

    click_on 'Add new Interesting'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Save'

    assert_selector 'ul.interestings', text: title
  end

  def add_event(title, year, month, day)
    visit_safely '/standups/today'

    click_on 'Add new Event'
    fill_in 'Title', with: title
    select year, from: 'event_date_1i'
    select month, from: 'event_date_2i'
    select day, from: 'event_date_3i'
    click_on 'Save'
  end

  def add_moment_of_zen(title, body)
    visit_safely '/standups/today'

    click_on 'Add Moment of Zen'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Save'
  end
end
