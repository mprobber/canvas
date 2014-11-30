class AddSaltToSiteModerator < ActiveRecord::Migration
  def change
    add_column :site_moderators, :salt, :string
  end
end
