class ChangePointsFormatInVote < ActiveRecord::Migration
  def change
    change_column :votes, :points, :double
  end
end
