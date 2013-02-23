class AddAttachmentBackimgToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.attachment :backimg
    end
  end

  def self.down
    drop_attached_file :cards, :backimg
  end
end
