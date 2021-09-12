# frozen_string_literal: true
require 'application_system_test_case'

class StandupsTest < ApplicationSystemTestCase
  include ActiveSupport::Testing::TimeHelpers

  test 'presenting standup for an average day' do
    add_backmaker('Alice')
    add_backmaker('Bob')
    add_interesting(
      'Banana poisoning',
      'Eating 10 million bananas at once would kill you'
    )
    add_event('Retrospective', '2026', 'January', '31')

    click_on 'Save'
    assert_selector 'ul.events', text: 'Retrospective'
    assert_selector 'p.zen', count: 0

    click_on 'Allez let\'s go'

    assert_selector 'section#interestings', text: "Interestings\n1"
    assert_selector 'section#backmakers', text: "La Team\n2"
    assert_selector 'section#events', text: "Events\n1"
    assert_selector '.spotlight'

    find('section#interestings').click
    assert_selector '.spotlight', text: /Banana poisoning/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Alice/
    assert_selector '.spotlight', text: /Bob/
    assert_no_text 'Banana poisoning'

    find('section#events').click
    assert_selector '.spotlight', text: /Retrospective : 2026-01-31/
  end

  test 'presenting standup on Friday' do
    travel_to(Date.parse('Friday')) do
      visit '/standups/today'
      click_on 'Add Moment of Zen'

      fill_in 'Title', with: 'Typical moment of zen'
      fill_in 'Body', with: 'http://example.com'
      click_on 'Save'

      assert_selector 'p.zen', text: 'All good on zen for now ...'

      click_on 'Allez let\'s go'
      assert_selector 'section#zen'
      assert_selector '.spotlight'

      find('section#zen').click
      assert_selector '.spotlight', text: /Typical moment of zen/
    end
  end

  def add_backmaker(name)
    visit backmakers_path

    click_on 'Add new BackMaker'
    fill_in 'Name', with: name
    click_on 'Save'

    assert_text name
  end

  def add_interesting(title, body)
    visit '/standups/today'

    click_on 'Add new Interesting'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Save'

    assert_selector 'ul.interestings', text: title
  end

  def add_event(title, year, month, day)
    visit '/standups/today'

    click_on 'Add new Event'
    fill_in 'Title', with: title
    select year, from: 'event_date_1i'
    select month, from: 'event_date_2i'
    select day, from: 'event_date_3i'
  end
end
