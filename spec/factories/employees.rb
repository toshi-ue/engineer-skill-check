# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:department_id) { Department.pluck(:id).sample }
    sequence(:office_id) { Office.pluck(:id).sample }
    sequence(:number, &:to_s)
    sequence(:last_name) { |n| "last_name#{n}" }
    sequence(:first_name) { |n| "first_name#{n}" }
    sequence(:account) { |n| "account_#{n}" }
    sequence(:password) { 'password' }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:date_of_joining) { Time.now - 1.hours }
    sequence(:employee_info_manage_auth) { [true, false].sample }
    sequence(:deleted_at) { [Time.now + 1.hours, nil].sample }
    sequence(:new_posting_auth) { [true, false].sample }
  end
end
