# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# create_table "meal_plans", force: :cascade do |t|
#     t.string "plan_title"
#     t.string "goal"
#     t.string "additional_preferences"
#     t.string "system_prompt"
#     t.string "diet"
#     t.string "meals_required"
#     t.bigint "user_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["user_id"], name: "index_meal_plans_on_user_id"
#   end

user = User.new(
  email: "email@email.com",
  password: "123456"
)

user.save!

meal_plan = MealPlan.new(
  user: user,
  plan_title: "Melissa's plan",
  goal: "more muscle",
  additional_preferences: "no eggs",
  system_prompt: "placeholder",
  meals_required: "no breakfast, 5 days per week lunch and dinner",
  diet: "omni"
)

meal_plan.save!
