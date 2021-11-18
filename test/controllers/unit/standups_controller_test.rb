# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class StandupsControllerUnitTest < ActiveSupport::TestCase
  test 'a backmaker cannot be MC for standup twice in a row' do
    Timecop.freeze Date.parse('Friday')

    alice = Backmaker.create(name: 'Alice')
    bob = Backmaker.create(name: 'Bob')
    Sprint.create(backmaker_id: alice.id)

    expected_args = [bob]
    stub = MiniTest::Mock.new
    stub.expect(:choose_one, bob, [expected_args])
    subject = StandupsController.new(nominator: stub)

    subject.present

    assert_equal('Bob', subject.next_week_mc)
    stub.verify
  end
end
