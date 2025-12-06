class Task < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :board
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
  validates :image, presence: true
  has_many :comments
end
