# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :author, null: false
      t.datetime :deleted_at, null: true, default: nil

      t.timestamps
    end
    add_foreign_key :articles, :employees, column: :author
  end
end
