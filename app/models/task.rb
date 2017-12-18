class Task < ApplicationRecord
  validates :tasks, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 255 }
end
