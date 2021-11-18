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

  test 'presenting standup clears the board' do
    Backmaker.new(name: 'Ariel').save
    Backmaker.new(name: 'Ursula').save

    Interesting.new(
      title: 'Killah Bees in your neighborhood',
      standup: Standup.last
    ).save

    get '/standups/today/present'
    assert_response :success
    assert_select 'section#interestings', text: /1/
    assert_select 'section#backmakers', text: /2/

    put '/standups/today', params: { presented: true }
    follow_redirect!
    assert_response :success

    assert_select 'ul.interestings', text: ''
  end

  test 'presenting a standup saves it in the database' do
    put '/standups/today', params: { presented: true }

    assert_equal Time.zone.today, Standup.last.date_of
  end
end
