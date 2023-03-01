# frozen_string_literal: true

class CreateOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :offices do |t|
      t.string        :name,        null: false
      t.datetime      :deleted_at,  null: true, default: nil

      t.timestamps
    end
  end
end
