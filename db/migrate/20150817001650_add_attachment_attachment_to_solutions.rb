class AddAttachmentAttachmentToSolutions < ActiveRecord::Migration
  def self.up
    change_table :solutions do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :solutions, :attachment
  end
end
