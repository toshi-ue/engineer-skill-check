# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references       :employee,   null: false
      t.text             :profile,    null: false
      t.datetime         :deleted_at, null: true, default: nil

      t.timestamps
    end
    add_foreign_key :profiles, :employees
  end
end
