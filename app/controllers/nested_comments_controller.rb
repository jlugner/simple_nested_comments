class NestedCommentsController < ApplicationController

  def create
    @commentable = find_commentable
    # Check if allowed to comment, should also be checked in view of course
    unless nested_commenting_allowed?(@commentable, current_user)
      if request.xhr?
        render html: "<div class='snc-error'>User is not allowed to comment on this object</div>".html_safe
      else
        redirect_to @commentable, alert: "Error adding comment. User is not allowed to comment on this object."
      end
      return
    end

    @nested_comment = @commentable.nested_comments.build(params[:nested_comment].permit(:content, :parent_id))
    @nested_comment.user = current_user
    if @nested_comment.save
      if request.xhr?
        render partial: "nested_comments/comment", object: @nested_comment
      else
        redirect_to @commentable, notice: "Successfully commented."
      end
    else
      if request.xhr?
        render html: "<div class='snc-error'>There was an error saving the comment</div>".html_safe
      else
        redirect_to @commentable, alert: "Error adding comment."
      end
    end
  end

  private
  def find_commentable
    return params[:nested_comment][:commentable_type].classify.constantize.find(
        params[:nested_comment][:commentable_id]
    )
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


