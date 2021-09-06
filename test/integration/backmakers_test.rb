# frozen_string_literal: true
require 'test_helper'

class BackMakersTest < ActionDispatch::IntegrationTest
  test 'add new backmakers to the squad' do
    Backmaker.all.each(&:delete)

    get '/backmakers'
    assert_response :success
    assert_select 'p', text: "There's no one here yet 😱"

    post '/backmakers', params: { backmaker: { name: 'Ursula' } }
    follow_redirect!
    assert_response :success

    assert_equal '/backmakers', path
    assert_equal "Let's welcome Ursula to the team", flash[:notice]
    assert_select 'ul.backmakers' do
      assert_select 'li', text: 'Ursula', count: 1
    end
  end
end
