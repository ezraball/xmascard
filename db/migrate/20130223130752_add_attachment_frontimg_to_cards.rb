class AddAttachmentFrontimgToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.attachment :frontimg
    end
  end

  def self.down
    drop_attached_file :cards, :frontimg
  end
end
