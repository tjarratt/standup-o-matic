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
  end
end
