class AddTopFlagToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :top_flag, :boolean, :default => false
  end
end
