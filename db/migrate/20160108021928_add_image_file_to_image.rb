class AddImageFileToImage < ActiveRecord::Migration

  def self.up
	add_attachment :images, :imagefile
  end

  def self.down
	remove_attachment :images, :imagefile
  end

end
