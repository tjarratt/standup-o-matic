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

  test 'presenting standup for the entire team' do
    add_backmakers('Alice', 'Bob', 'Carol', 'David')
    add_moment_of_zen('Typical moment of zen', 'https://zombo.com')
    assert_selector 'p.zen', text: 'All good on zen for now ...'

    click_on_safely 'Allez let\'s go'

    # this is necessary because the click handlers are added after the document loads
    # ie : the text is in the DOM but the clickhandler not yet installed
    sleep 0.3 

    find('section#zen').click
    assert_selector '.spotlight', text: /Typical moment of zen/

    find('section#backmakers').click

    find('.spotlight li', text: 'Alice').click
    find('.spotlight li', text: 'Bob').click
    find('.spotlight li', text: 'Carol').click
    find('.spotlight li', text: 'David').click

    assert_no_js_errors
  end
 
  test 'MCs can be nominated around the end of the week' do
    add_backmakers('Alice', 'Bob')

    Timecop.freeze(Date.parse('monday'))
    visit_safely '/standups/today/present'
    assert_selector 'section#next-mc', count: 0

    Timecop.freeze(Date.parse('tuesday'))
    visit_safely '/standups/today/present'
    assert_selector 'section#next-mc', count: 0
    
    Timecop.freeze(Date.parse('wednesday'))
    visit_safely '/standups/today/present'
    assert_selector 'section#next-mc', count: 0

    Timecop.freeze(Date.parse('thursday'))
    visit_safely '/standups/today/present'
    assert_selector 'section#next-mc'

    Timecop.freeze(Date.parse('friday'))
    visit_safely '/standups/today/present'
    assert_selector 'section#next-mc'
  end

  test 'nominating an MC for next week' do
    thursday = Date.parse('Thursday')
    Timecop.freeze(thursday)

    add_backmakers('Alice', 'Bob')

    visit_safely '/standups/today'
    click_on_safely 'Allez let\'s go'

    # this is necessary because the click handlers are added after the document loads
    # ie : the text is in the DOM but the clickhandler not yet installed
    sleep 0.3
    assert_selector 'section#next-mc'

    Timecop.freeze(thursday + 1)
    visit_safely '/standups/today/present'

    find('section#next-mc').click
    select 'Alice', from: 'nextMC'
    click_on_safely 'Make it so'
    click_on_safely 'Standup is DONE'

    assert_selector 'h4', text: 'Your MC this week is ... Alice'
    assert_no_js_errors
  end
end
