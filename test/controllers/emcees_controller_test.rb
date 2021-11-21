# frozen_string_literal: true
require 'test_helper'

class EmceesControllerTest < ActionDispatch::IntegrationTest
  test 'you can override the current week\'s MC' do
    alice = Backmaker.create(name: 'Alice')
    bob = Backmaker.create(name: 'Bob')
    Sprint.create(backmaker_id: alice.id)

    get '/emcees'
    assert_response :success

    assert_select 'h3', 'Our current MC is Alice'

    put '/emcees/current', params: { backmaker_id: bob.id }
    follow_redirect!
    assert_response :success
    assert_equal bob.id, Sprint.last.backmaker_id

    get '/emcees'
    assert_select 'h3', 'Our current MC is Bob'
  end
end
