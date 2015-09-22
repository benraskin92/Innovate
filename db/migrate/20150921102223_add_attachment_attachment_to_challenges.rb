class AddAttachmentAttachmentToChallenges < ActiveRecord::Migration
  def self.up
    change_table :challenges do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :challenges, :attachment
  end
end
