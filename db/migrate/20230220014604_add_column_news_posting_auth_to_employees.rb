class AddColumnNewsPostingAuthToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :news_posting_auth, :boolean, after: :employee_info_manage_auth, default: false, null: false
  end
end
