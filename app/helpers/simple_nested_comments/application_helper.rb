module SimpleNestedComments
  module ApplicationHelper
    def display_nested_comments_for(commentable)

      nested_comments = commentable.nested_comments.arrange(:order => :created_at)

      render partial: 'nested_comments/nested_comments',
             object: nested_comments,
             locals: {parent_id: nil, commentable: commentable}

    end

    def nested_commenting_allowed?(commentable, user)
      if current_user
        if commentable.respond_to?(:nested_commenting_allowed_for?)
          commentable.nested_commenting_allowed_for?(user)
        else
          true
        end
      else
        false
      end
    end
  end
end
