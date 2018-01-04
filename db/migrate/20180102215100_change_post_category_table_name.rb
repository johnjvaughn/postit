class ChangePostCategoryTableName < ActiveRecord::Migration
  def change
    rename_table :categories_posts, :category_posts
  end
end
