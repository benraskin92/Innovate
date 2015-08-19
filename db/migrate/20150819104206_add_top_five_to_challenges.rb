class AddTopFiveToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :top_five, :boolean, null: false, default: false
  end
end
