# frozen_string_literal: true
class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :events, :standups do |t|
      # t.index [:event_id, :standup_id]
      # t.index [:standup_id, :event_id]
    end
  end
end
