class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :name
      t.text :description
      t.integer :severity
      t.integer :site_moderator_id

      t.timestamps
    end
  end
end
