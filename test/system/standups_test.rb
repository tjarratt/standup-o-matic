# frozen_string_literal: true
require 'application_system_test_case'

class StandupsTest < ApplicationSystemTestCase
  include ActiveSupport::Testing::TimeHelpers

  test 'presenting standup for an average day' do
    add_backmaker('Alice')
    add_backmaker('Bob')

    visit '/standups/today'
    assert_text 'Alice'
    assert_text 'Bob'

    click_on 'Add new Interesting'

    fill_in 'Title', with: 'Banana poisoning'
    fill_in 'Body', with: 'Eating 10 million bananas at once would kill you'
    click_on 'Save'

    assert_selector 'ul.interestings', text: 'Banana poisoning'

    assert_selector 'p.zen', count: 0

    click_on 'Allez let\'s go'
    assert_selector 'section#interestings', text: "Interestings\n1"
    assert_selector 'section#backmakers', text: "La Team\n2"
    assert_selector '.spotlight'

    find('section#interestings').click
    assert_selector '.spotlight', text: /Banana poisoning/

    find('section#backmakers').click
    assert_selector '.spotlight', text: /Alice/
    assert_selector '.spotlight', text: /Bob/
    assert_no_text 'Banana poisoning'
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
end
