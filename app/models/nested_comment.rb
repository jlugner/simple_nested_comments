class NestedComment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  validates_presence_of :user

  belongs_to :commentable, :polymorphic => true
end
