class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :homebrew_id, null: false
      t.integer :reviewer_id, null: false
      t.integer :rating, null: false
      t.text :body

      t.timestamps null: false
    end

    add_index :reviews, [:homebrew_id, :reviewer_id], unique: true
  end
end
