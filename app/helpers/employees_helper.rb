# frozen_string_literal: true

module EmployeesHelper
  def sort_order(column, title)
    direction = params[:direction] == 'desc' ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction }
  end
end
