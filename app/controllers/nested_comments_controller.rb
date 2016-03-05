class NestedCommentsController < ApplicationController

  def create
    @commentable = find_commentable
    # How to check if user is allowed to comment on this commentable, that check goes here
    @nested_comment = @commentable.nested_comments.build(params[:nested_comment].permit(:content, :parent_id))
    @nested_comment.user = current_user
    if @nested_comment.save
      if request.xhr?
        render json: {success: true}
      else
        redirect_to @commentable, notice: "Successfully commented.", status: :created
      end
    else
      if request.xhr?
        render json: {success: false, errors: @nested_comment.errors}, status: :server_error
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

end


