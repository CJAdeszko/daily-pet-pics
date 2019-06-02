class AddPostViewsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_views, :integer, default: 0
  end
end
