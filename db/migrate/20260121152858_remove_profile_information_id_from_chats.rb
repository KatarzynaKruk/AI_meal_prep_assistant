class RemoveProfileInformationIdFromChats < ActiveRecord::Migration[7.1]
  def change
    remove_column :chats, :profile_information_id, :bigint
  end
end
