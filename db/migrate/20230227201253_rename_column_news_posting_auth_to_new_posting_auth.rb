class RenameColumnNewsPostingAuthToNewPostingAuth < ActiveRecord::Migration[6.1]
  def change
    rename_column :employees, :news_posting_auth, :new_posting_auth
  end
end
