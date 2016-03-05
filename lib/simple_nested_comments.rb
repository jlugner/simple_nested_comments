require "simple_nested_comments/engine"

module SimpleNestedComments
  extend ActiveSupport::Concern

  module ClassMethods
    def has_nested_comments
      has_many :nested_comments, as: :commentable
      before_destroy { |record| record.root_comments.destroy_all }
      include SimpleNestedComments::LocalInstanceMethods
      extend SimpleNestedComments::SingletonMethods
    end
  end

  # This module contains class methods
  module SingletonMethods
    # Helper method to lookup for comments for a given object.
    # This method is equivalent to obj.comments.
    def find_comments_for(obj)
      Comment.where(commentable_id: obj.id,
                    commentable_type: obj.class.base_class.name)
          .order('created_at DESC')
    end

    # Helper class method to lookup comments for
    # the mixin commentable type written by a given user.
    # This method is NOT equivalent to Comment.find_comments_for_user
    def find_comments_by_user(user)
      commentable = base_class.name.to_s
      Comment.where(user_id: user.id, commentable_type: commentable)
          .order('created_at DESC')
    end
  end

  module LocalInstanceMethods
    # Helper method to display only root threads, no children/replies
    def root_comments
      comment_threads.where(parent_id: nil)
    end

    # Helper method to sort comments by date
    def comments_ordered_by_submitted
      Comment.where(commentable_id: id, commentable_type: self.class.name)
          .order('created_at DESC')
    end

    # Helper method that defaults the submitted time.
    def add_comment(comment)
      comments << comment
    end
  end
end


ActiveRecord::Base.send(:include, SimpleNestedComments)

