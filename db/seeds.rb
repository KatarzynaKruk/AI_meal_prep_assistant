# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.new(
  email: "email@hotmail.com",
  password: "123456"
)

user.save!

profile_information = ProfileInformation.new(
  user: user,
  name: "Kasia",
  height: 123,
  weight: 23.6,
  restrictions: "should not eat nuts",
  conditions: "diabetes",
  date_of_birth: "1988-01-01"
)

profile_information.save!
