class Note < ApplicationRecord
  belongs_to :tag
  validates :body, presence: true, length: { maximum: 10_000 }
end
