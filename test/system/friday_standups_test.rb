# frozen_string_literal: true
require 'application_system_test_case'

class FridayStandupsTest < ApplicationSystemTestCase
  include ActiveSupport::Testing::TimeHelpers

  test 'preparing for a jolly moment of zen on Thursday' do
    travel_to Date.parse('thursday')

    add_backmakers('Alice', 'Bob')
    visit_safely '/standups/today'
    assert_selector 'section#zen', count: 0

    click_on_safely 'Allez let\'s go'
    click_on_safely 'Standup is DONE'

    assert_selector 'section#zen'
  end

  test 'presenting standup on Friday' do
    friday = Date.parse('friday')
    travel_to friday

    add_backmakers('Alice', 'Bob', 'Carol', 'David')
    add_moment_of_zen('Typical moment of zen', 'https://zombo.com')
    assert_selector 'p.zen', text: 'All good on zen for now ...'

    click_on_safely 'Allez let\'s go'

    sleep 0.3 # possibly necessary because we don't update the DOM all in one go ?

    # ie : the text is in the DOM but the clickhandler not yet installed
    find('section#zen').click
    assert_selector '.spotlight', text: /Typical moment of zen/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Next week's MC is .../, count: 0

    find('.spotlight li', text: 'Alice').click
    find('.spotlight li', text: 'Bob').click
    find('.spotlight li', text: 'Carol').click
    find('.spotlight li', text: 'David').click

    assert_selector '.spotlight', text: /Next week's MC will be .../

    select 'Alice', from: 'nextMC'
    click_on_safely 'Make it so'
    click_on_safely 'Standup is DONE'

    travel_to friday + 3
    visit_safely '/standups/today'

    assert_selector 'h4', text: 'Your MC this week is ... Alice'
    assert_no_js_errors
  end
end
