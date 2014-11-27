module CommentsHelper

  def can_delete_comment?(comment)
    (comment.user_id == current_user.id) || if_admin? unless current_user.nil?
  end

end
