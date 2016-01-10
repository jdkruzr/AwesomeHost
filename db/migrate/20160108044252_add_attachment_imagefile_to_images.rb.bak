class AddAttachmentImagefileToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :imagefile
    end
  end

  def self.down
    remove_attachment :images, :imagefile
  end
end
