# frozen_string_literal: true
class CreateMomentOfZens < ActiveRecord::Migration[6.1]
  def change
    create_table :moment_of_zens do |t|
      t.string :title
      t.text :body
      t.references :standup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
