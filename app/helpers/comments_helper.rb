module CommentsHelper
  def convert_to_image_tag(comment)
    if comment.match(/^((https:\/\/media)\d(\.giphy\.com\/media))/)
      return image_tag("#{comment}", size:'100')
    else
      comment
    end
  end
end
