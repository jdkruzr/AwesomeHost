class ImagesController < ApplicationController

# There is some magic in here we need to make sure works:
# 1) Tags need to find their way to where they need to go from the view, despite tags not
# being an actual part of the image model
# 2) We want to take the %FILENAME.EXT% uploaded from Paperclip and put it into
# @image.filename
# 3) Make sure the index only applies to the images that belong to the user
# 4) Does that :imagefile thing work the way I think it does for Paperclip?

	def index
		@images = Image.all
	end

	def create
		@image = Image.new(image_params)
		
		if @image.save
			redirect_to @image
		else
			render 'new'
		end
	end
	
	def new
		@image = Image.new
	end
	
	def edit
		@image = Image.find(params[:id])
	end
	
	private
	
	def image_params
		params.require(:image).permit(:description, :tags, :imagefile)
	end
	
end
