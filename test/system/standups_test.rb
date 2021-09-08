# frozen_string_literal: true
require 'application_system_test_case'

class StandupsTest < ApplicationSystemTestCase
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

    click_on 'Allez let\'s go'
    assert_selector 'section.interestings', text: "Interestings\n1"
    assert_selector 'section.backmakers', text: "BackMakers\n2"
    assert_selector '.spotlight'

    find('.interestings').click
    assert_selector '.spotlight', text: /Banana poisoning/

    find('.backmakers').click
    assert_selector '.spotlight', text: /Alice/
    assert_selector '.spotlight', text: /Bob/
    assert_no_text 'Banana poisoning'
  end

  def add_backmaker(name)
    visit backmakers_path
    click_on 'Add new BackMaker'
    fill_in 'Name', with: name
    click_on 'Save'
    assert_text name
  end
end
