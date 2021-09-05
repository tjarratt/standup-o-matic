require 'test_helper'

class StandupsTest < ActionDispatch::IntegrationTest
  test "add a crusty interesting thing to today's standup" do
    get '/standups/today'
    assert_response :success
    assert_select 'ul.interestings li', count: 0

    post '/standups/today/interestings',
         params: {
           title: 'UK Bees Act of 1980',
           body: 'Can you believe this GRAWLIX???'
         }
    follow_redirect!
    assert_response :success

    assert_equal '/standups/today', path
    assert_select 'ul.interestings li', text: 'UK Bees Act of 1980', count: 1
  end

  test 'presenting standup flow' do
    skip
  end
end
