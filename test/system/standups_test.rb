# frozen_string_literal: true
require 'application_system_test_case'

class StandupsTest < ApplicationSystemTestCase
  test 'presenting standup for an average day' do
    visit backmakers_path
    assert_selector 'h1', text: 'BackMakers'

    click_on 'Add new BackMaker'

    fill_in 'Name', with: 'Ursula'
    click_on 'Save'

    assert_text 'Ursula'

    visit '/standups/today'

    assert_text 'Ursula'

    click_on 'Add new Interesting'

    fill_in 'Title', with: 'Banana poisoning'
    fill_in 'Body', with: 'Eating 10 million bananas at once would kill you'
    click_on 'Save'

    assert_selector 'ul.interestings', text: 'Banana poisoning'
  end
end
