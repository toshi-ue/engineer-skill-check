# frozen_string_literal: true

class Office < ApplicationRecord
  has_many :employees
end
