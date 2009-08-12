class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :blog_id
      t.text :body
      t.string :email
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
