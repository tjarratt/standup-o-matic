# frozen_string_literal: true
class CreateInterestings < ActiveRecord::Migration[6.1]
  def change
    create_table :interestings do |t|
      t.string :title
      t.text :body
      t.references :standup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
