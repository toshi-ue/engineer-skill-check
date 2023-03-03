# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe '#index' do
    let!(:employee) { create(:employee) }

    context 'ログインしているとき' do
      it '200 を返すこと' do
        login_as employee
        get employees_path
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end

    context 'ゲストのとき' do
      it 'ログインページへリダイレクトされること' do
        get employees_path
        expect(response).to_not be_successful
        expect(response).to have_http_status '302'
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#new' do
    let!(:new_employee) { create(:employee) }

    context 'ログインしているとき' do
      it '社員登録ページが表示されること' do
        login_as new_employee
        get new_employee_path
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response.body).to include '保存'
      end
    end
  end

  describe '#create' do
    let!(:new_employee) { create(:employee) }

    context 'ログインしているとき' do
      context '値が適正であるとき' do
        it '登録できること' do
          login_as new_employee
          expect do
            post employees_path, params: { employee: attributes_for(:employee) }
          end.to change(Employee, :count).by(1)
          expect(response).to redirect_to employees_path
        end
      end
      context '値が適正でないとき' do
        it '登録できないこと' do
          login_as new_employee
          expect do
            post employees_path, params: { employee: attributes_for(:employee, password: '') }
          end.to_not change(Employee, :count)
        end
      end
    end
  end

  describe '#edit' do
    let!(:new_employee) { create(:employee) }

    context 'ログインしているとき' do
      it '社員編集ページが表示されること' do
        login_as new_employee
        get edit_employee_path new_employee
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response.body).to include '保存'
      end
    end
  end

  describe '#update' do
    let!(:new_employee) { create(:employee) }

    context 'ログインしているとき' do
      context '値が適正であるとき' do
        it '更新できること' do
          login_as new_employee
          expect do
            patch employee_path new_employee,
                                params: { employee: attributes_for(:employee,
                                                                   account: Faker::Internet.unique.free_email) }
          end.to change(Employee, :count).by(0)
          expect(response).to redirect_to employees_path
        end
      end

      context '値が適正でないとき' do
        it '更新ができないこと' do
          login_as new_employee
          expect do
            patch employee_path new_employee, params: { employee: new_employee.attributes }
          end.to_not change(Employee, :count)
        end
      end
    end
  end

  describe '#destroy' do
    let!(:new_employee) { create(:employee, employee_info_manage_auth: true) }
    let!(:other_employee) { create(:employee) }

    context 'ログインしているとき' do
      # QUESTION: テストがパスするときとしないときがある
      it '削除できること' do
        login_as new_employee

        expect do
          delete employee_path other_employee
        end.to change(Employee.active, :count).by(-1)
        expect(response).to redirect_to employees_path
      end
    end
  end
end
