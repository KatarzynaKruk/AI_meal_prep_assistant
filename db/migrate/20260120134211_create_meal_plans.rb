class CreateMealPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_plans do |t|
      t.string :plan_title
      t.string :goal
      t.string :additional_preferences
      t.string :system_prompt
      t.string :diet
      t.string :meals_required
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
