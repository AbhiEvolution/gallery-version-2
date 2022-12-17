module ApplicationHelper
  #   def likes(album, options = {})
  def likes(album, current_user)
    pre_like = album.likes.find { |like| like.user_id == current_user.id }
    if pre_like
      button_to album_like_path(album, pre_like), method: :delete, class: "fa fa-heart-o fs-5 border-0  bg-light", style: "color:red;" do
      end
    else
      button_to album_likes_path(album), method: :post, class: "fa fa-heart-o fs-5 border-0 bg-light" do
      end
    end
  end

  def all_likes(album)
    a = []
    @user_like = album.likes
  end
end
