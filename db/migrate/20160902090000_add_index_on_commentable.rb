class AddIndexOnCommentable < ActiveRecord::Migration
  def change
    add_index :nested_comments, [:commentable_id, :commentable_type]
  end
end
