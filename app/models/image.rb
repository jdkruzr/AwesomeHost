class Image < ActiveRecord::Base
	has_attached_file :imagefile, styles: {
    		thumb: '100x100>',
    		square: '200x200#',
    		medium: '300x300>'
  		}
	validates_attachment_content_type :imagefile, content_type: /\Aimage\/.*\Z/
	belongs_to :user
	has_many :images_tags
	has_many :tags, through: :images_tags

	# We're defining this to permit getting and setting tags on Images.
	
	def tag_names
		tags.map { |tag| tag.name }.join(' ')
	end
	
	# If you don't put "self" here, it assumes you mean a local variable.
	def tag_names=(names)
		self.tags = names.split(' ').map do |tag_name|
			Tag.new name: tag_name
		end
	end

	def self.search(query, user)
           user.images.select{|i| i.tag_names =~ /#{query}/ || i.description =~ /#{query}/ }
    end
end

# .where("self.tag_names LIKE :query OR description LIKE :query", query: "%#{query}%")