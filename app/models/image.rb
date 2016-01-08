class Image < ActiveRecord::Base
	has_attached_file :imagefile, styles: {
    		thumb: '100x100>',
    		square: '200x200#',
    		medium: '300x300>'
  		}

	belongs_to :user
	has_many :tags
end
