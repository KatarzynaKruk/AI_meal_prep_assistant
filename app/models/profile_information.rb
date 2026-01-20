class ProfileInformation < ApplicationRecord
  belongs_to :user

  validates :name, :height, :weight, :date_of_birth, presence: true
  validates :height, :weight, numericality: true
end
