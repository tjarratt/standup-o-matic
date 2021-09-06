# frozen_string_literal: true
class CreateStandups < ActiveRecord::Migration[6.1]
  def change
    create_table :standups do |t|
      t.date :date_of
      t.string :presenter

      t.timestamps
    end
  end
end
