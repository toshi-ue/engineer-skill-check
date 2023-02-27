# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_artcle, only: %i[edit update destroy]

  def index
    @articles = Article.includes(:author)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_url, notice: "おしらせ 「#{@article.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to articles_url, notice: "おしらせ「#{@article.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.now
      @article.update_column(:deleted_at, now)
    end

    redirect_to articles_url, notice: "おしらせ「#{@article.title}」を削除しました。"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :deleted_at)
  end

  def set_article
    @article = Article.find(params['id']).includes(:employee)
  end
end