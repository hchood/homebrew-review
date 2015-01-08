class CreateHomebrews < ActiveRecord::Migration
  def change
    create_table :homebrews do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.date :date_brewed, null: false
      t.text :description

      t.timestamps
    end

    add_index :homebrews, [:name, :date_brewed], unique: true
  end
end
