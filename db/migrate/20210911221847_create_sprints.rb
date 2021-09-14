# frozen_string_literal: true
class CreateSprints < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints do |t|
      t.references :backmaker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
