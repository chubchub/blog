class ModifyBlogs < ActiveRecord::Migration
  def self.up
    change_column :blogs, :views, :integer, :default => 0
  end

  def self.down
    change_column :blogs, :views, :integer, :default => nil
  end
end
