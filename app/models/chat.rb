class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :meal_plan
  # belongs_to :profile_information

  has_many :messages, dependent: :destroy

  validates :user_id, presence: true
  validates :user, :meal_plan, presence: true
  validates :meal_plan, presence: true
end
