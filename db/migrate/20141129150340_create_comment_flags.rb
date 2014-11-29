class CreateCommentFlags < ActiveRecord::Migration
  def change
    create_table :comment_flags do |t|
      t.integer :comment_id
      t.integer :flag_id
      t.integer :user_id
      t.integer :moderator_id
      t.boolean :is_good
      t.text :description

      t.timestamps
    end
  end
end
