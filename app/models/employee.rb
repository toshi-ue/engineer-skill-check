# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :office
  belongs_to :department
  has_many :articles, foreign_key: :author
  has_many :profiles

  validates :number, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :account, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_joining, presence: true

  with_options if: :create_or_update_email? do
    validates :email, confirmation: { case_sensitive: true }
  end

  scope :active, lambda {
    where(deleted_at: nil)
  }

  def create_or_update_email?
    return true if email_in_database.nil?
    return true if will_save_change_to_email?

    false
  end
end
