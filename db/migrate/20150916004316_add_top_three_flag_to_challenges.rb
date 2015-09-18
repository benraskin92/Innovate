class AddTopThreeFlagToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :top_three_flag, :boolean, :default => false
  end
end
