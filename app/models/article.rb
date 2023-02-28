# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :author, class_name: 'Employee', foreign_key: :author

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1000 }

end
