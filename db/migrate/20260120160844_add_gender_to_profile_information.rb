class AddGenderToProfileInformation < ActiveRecord::Migration[7.1]
  def change
    add_column :profile_informations, :gender, :string
  end
end
