class MealPlan < ApplicationRecord
  belongs_to :user

  validates :goal, :system_prompt, :user, :diet, presence: true
  validates :additional_preferences, :meals_required, presence: true, allow_blank: true
  validates :additional_preferences, :meals_required, length: { maximum: 200 }
end
