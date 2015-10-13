class RemoveTopFromChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :top_five, :boolean
  end
end
