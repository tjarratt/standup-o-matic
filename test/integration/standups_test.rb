# frozen_string_literal: true
require 'test_helper'

class StandupsTest < ActionDispatch::IntegrationTest
  test 'adding an interesting adds it to the home page' do
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

  test 'adding a BackMaker adds it to the home page' do
    get '/standups/today'
    assert_response :success
    assert_select 'ul.backmakers li', count: 0

    Backmaker.new(name: 'Ursula').save

    get '/standups/today'
    assert_response :success
    assert_select 'ul.backmakers li', text: 'Ursula', count: 1
  end
end
