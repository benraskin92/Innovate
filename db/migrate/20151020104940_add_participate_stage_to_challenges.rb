class AddParticipateStageToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :participate_stage, :boolean, :default => false
  end
end
