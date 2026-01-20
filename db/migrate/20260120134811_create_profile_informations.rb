class CreateProfileInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :profile_informations do |t|
      t.string :name
      t.float :height
      t.float :weight
      t.text :restrictions
      t.string :conditions
      t.date :date_of_birth
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
