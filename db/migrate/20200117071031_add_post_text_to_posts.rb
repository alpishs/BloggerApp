class AddPostTextToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :post_text, :text
  end
end
