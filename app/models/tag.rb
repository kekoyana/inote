# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :notes, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
