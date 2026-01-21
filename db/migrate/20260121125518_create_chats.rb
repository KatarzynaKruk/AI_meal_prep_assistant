class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true
      t.references :profile_information, null: false, foreign_key: true

      t.timestamps
    end
  end
end
