class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..10 }
  validates :movie_id, uniqueness: { scope: :list_id }
end
