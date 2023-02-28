# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :author, class_name: 'Employee', foreign_key: :author

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1000 }

  scope :active, lambda {
    where(deleted_at: nil)
  }

  def owner?(user_id)
    return user_id == self.author.id
  end
end
