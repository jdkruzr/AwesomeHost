class ImagesController < ApplicationController

	before_filter :authenticate_user!, only: [ :new, :create, :edit, :update, :delete ]

# There is some magic in here we need to make sure works:
# 1) Tags need to find their way to where they need to go from the view, despite tags not
# being an actual part of the image model
# 2) We want to take the %FILENAME.EXT% uploaded from Paperclip and put it into
# @image.filename
# 3) Make sure the index only applies to the images that belong to the user
# 4) Does that :imagefile thing work the way I think it does for Paperclip?
# 5) Need to make search work
# 6) Implement Imgur API?

	def index
		if user_signed_in?
			@search = params[:search]
			if @search
				@images = Image.search(@search, current_user)
			else
				@images = current_user.images # This needs to be "where Image.user = logged_in_user" or something
			end
			
		else
			@images = nil
		end
	end

	def create
		@image = current_user.images.new(image_params)

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
	
	def show
		@image = Image.find(params[:id])
	end
	
	def destroy
		@image = Image.find(params[:id])
  		@image.destroy
 
  		redirect_to root_path
	end
	
	def update
		@image = Image.find(params[:id])
		
		if @image.update(image_params)
			redirect_to @image
		else
			render 'edit'
		end
	end
	
	private
	
	def image_params
		params.require(:image).permit(:description, :tag_names, :imagefile)
	end
	
end
