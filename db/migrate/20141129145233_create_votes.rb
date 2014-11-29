class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :points

      t.timestamps
    end
  end
end
