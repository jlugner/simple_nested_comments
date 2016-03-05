module SimpleNestedComments
  module ApplicationHelper
    def display_nested_comments_for(commentable)

      nested_comments = commentable.nested_comments.arrange(:order => :created_at)

      render partial: 'nested_comments/nested_comments',
             object: nested_comments,
             locals: {parent_id: nil, commentable: commentable}

    end
  end
end
