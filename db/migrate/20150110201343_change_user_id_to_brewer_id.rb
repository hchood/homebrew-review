class ChangeUserIdToBrewerId < ActiveRecord::Migration
  def change
    rename_column :homebrews, :user_id, :brewer_id
  end
end
