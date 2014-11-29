class CreateSiteModerators < ActiveRecord::Migration
  def change
    create_table :site_moderators do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :password_digest

      t.timestamps
    end
  end
end
