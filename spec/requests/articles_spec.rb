# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:new_employee) { create(:employee, new_posting_auth: true) }
  let!(:article) { create(:article, author: new_employee) }

  describe '#index' do
    context 'ログインしているとき' do
      it '200 を返すこと' do
        login_as new_employee
        get articles_path
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end

    context 'ゲストのとき' do
      it 'ログインページへリダイレクトされること' do
        get articles_path
        expect(response).to_not be_successful
        expect(response).to have_http_status '302'
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#new' do
    context 'ログインしているとき' do
      it '新規お知らせページが表示されること' do
        login_as new_employee
        get new_article_path
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(response.body).to include '保存'
      end
    end
  end

  describe '#create' do
    context 'ログインしているユーザーにお知らせ投稿権限があるとき' do
      context '値が適正であるとき' do
        it '登録できること' do
          login_as new_employee
          expect do
            post articles_path, params: { article: attributes_for(:article) }
          end.to change(Article, :count).by(1)
          expect(response).to redirect_to articles_path
        end
      end
      context '値が適正でないとき' do
        it '登録できないこと' do
          login_as new_employee
          expect do
            post articles_path, params: { article: attributes_for(:article, title: '') }
          end.to_not change(Employee, :count)
        end
      end
    end
  end
end
