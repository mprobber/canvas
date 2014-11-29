class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :category_id
      t.text :comment
      t.integer :ip

      t.timestamps
    end
  end
end
