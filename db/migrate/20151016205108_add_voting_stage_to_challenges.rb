class AddVotingStageToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :voting_stage, :boolean, :default => false
  end
end
