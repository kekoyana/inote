# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
