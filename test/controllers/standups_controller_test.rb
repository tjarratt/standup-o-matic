# frozen_string_literal: true
require 'test_helper'

class StandupsControllerTest < ActionDispatch::IntegrationTest
  test 'fridays benefit from a moment of zen' do
    Timecop.freeze Date.parse('Friday') do
      get '/standups/today'
      assert_response :success

      assert_select 'section#zen', count: 1

      MomentOfZen.new(title: 'toto', body: 'foobar', standup: Standup.last)
        .save!

      get '/standups/today/present'
      assert_response :success

      assert_select 'section#zen', count: 1
    end
  end

  test 'other days do not have a moment of zen' do
    MomentOfZen.new(title: 'tata', body: 'foobiz', standup: Standup.last).save!

    %w[monday tuesday wednesday thursday].each do |day|
      Timecop.freeze Date.parse(day)

      get '/standups/today'
      assert_select 'section#zen', count: 0

      get '/standups/today/present'

      assert_select 'section#zen', count: 0
    end
  end
end
