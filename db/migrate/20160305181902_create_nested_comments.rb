class CreateNestedComments < ActiveRecord::Migration
  def change
    create_table :nested_comments do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.string :ancestry

      t.timestamps null: false
    end
    add_index :nested_comments, :ancestry
  end
end
