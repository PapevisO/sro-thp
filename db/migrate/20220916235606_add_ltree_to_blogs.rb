class AddLtreeToBlogs < ActiveRecord::Migration[5.2]
  def self.up
    add_column :blogs, :parent_id, :integer
    add_column :blogs, :path, :ltree

    add_index :blogs, :parent_id
  end

  def self.down
    remove_index :blogs, :parent_id
    remove_column :blogs, :parent_id
    remove_column :blogs, :path
  end
end
