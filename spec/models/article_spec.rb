# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'scope' do
    describe 'active' do
      let!(:active_article) { create(:article, deleted_at: nil) }
      let!(:inactive_article) { create(:article, deleted_at: Time.now) }

      it 'データを取得できること' do
        expect(Article.active).to include active_article
      end

      it 'データを取得しないこと' do
        expect(Article.active).to_not include inactive_article
      end
    end
  end

  describe '#owner?(user_id)' do
    let(:employee) { create(:employee) }
    let(:other_employee) { create(:employee) }
    let!(:article) { build(:article, author: employee) }

    context 'ユーザーがarticleの作成者であるとき' do
      it 'true を返す' do
        article.author = employee
        expect(employee.id == article.author.id).to be_truthy
      end
    end

    context 'ユーザーがarticleの作成者でないとき' do
      it 'false を返す' do
        article.author = other_employee
        expect(employee.id == article.author.id).to be_falsey
      end
    end
  end
end
