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

    click_on_safely 'Allez let\'s go'

    assert_selector 'section#interestings', text: "Interestings\n1"
    assert_selector 'section#backmakers', text: "La Team\n2"
    assert_selector 'section#events', text: "Events\n1"

    find('section#interestings').click
    assert_selector '.spotlight', text: /Banana poisoning/
    assert_selector '.spotlight', text: /Eating 10 million bananas/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Alice/
    assert_selector '.spotlight', text: /Bob/
    assert_no_text 'Banana poisoning'

    find('section#events').click
    assert_no_js_errors
    assert_selector '.spotlight', text: /Retrospective : 2026-01-31/
  end

  test 'presenting without a full team' do
    Timecop.freeze Date.parse('Friday')

    visit_safely '/standups/today'
    click_on_safely 'Allez let\'s go'

    assert_selector 'section#backmakers', count: 0
    assert_no_js_errors
  end
end
