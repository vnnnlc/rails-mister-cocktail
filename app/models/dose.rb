class Dose < ApplicationRecord
  belongs_to :cocktail, inverse_of: :doses
  belongs_to :ingredient

  validates :cocktail, presence: true, uniqueness: { scope: :ingredient }
  validates :ingredient, presence: true
end
