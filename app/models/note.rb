# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :tag
  validates :tag_id, presence: true
  validates :body, presence: true, length: { maximum: 10_000 }
end
