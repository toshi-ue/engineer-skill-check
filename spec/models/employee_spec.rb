# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'scope' do
    describe 'active' do
      let!(:active_employee) { create(:employee, deleted_at: nil) }
      let!(:inactive_employee) { create(:employee, deleted_at: Time.now) }

      it 'データを取得できること' do
        expect(Employee.active).to include active_employee
      end

      it 'データを取得しないこと' do
        expect(Employee.active).to_not include inactive_employee
      end
    end
  end

  describe '#create_or_update_email?' do
    let(:new_employee) { create(:employee, deleted_at: nil, email: 'example1@example.com') }
    let!(:existing_employee) { create(:employee, deleted_at: nil, email: 'example2@example.com') }

    # QUESTION: テストの書き方が違う?
    context 'データベースに同じメールアドレスが存在するとき' do
      it 'falseを返す' do
        new_employee.email = existing_employee.email
        expect(new_employee).to be_invalid
      end
    end

    context 'データベースに同じメールアドレスが存在しないとき' do
      it 'trueを返す' do
        new_employee.email = Faker::Internet.unique.free_email
        expect(new_employee).to be_valid
      end
    end

    # TODO: return true if will_save_change_to_email? のテストの方法を調べる
  end
end
