# frozen_string_literal: true
class CreateBackmakers < ActiveRecord::Migration[6.1]
  def change
    create_table :backmakers do |t|
      t.string :name

      t.timestamps
    end
  end
end
