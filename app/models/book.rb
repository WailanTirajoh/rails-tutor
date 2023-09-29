class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, length: { minimum: 3 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end
end
