class AddQuickFixToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :quick_fix, :boolean, :default => false
  end
end
