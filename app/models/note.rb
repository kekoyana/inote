# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :tag
  validates :tag_id, presence: true
  validates :body, presence: true, length: { maximum: 10_000 }

  def self.create_by(tag:, body:)
    transaction do
      tag_obj = Tag.find_or_create_by(name: tag)
      create!(tag: tag_obj, body: body)
    end
  rescue StandardError => e
    logger.error(e)
    false
  end
end
