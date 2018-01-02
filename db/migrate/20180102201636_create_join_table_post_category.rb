class CreateJoinTablePostCategory < ActiveRecord::Migration
  def change
    create_join_table :posts, :categories do |t|
    end
  end
end
