class TracesController < ApplicationController
	def index
		@cards = (0...100).to_a #for 100 cards. /change this when records are more.
	end

	def create
		attributes = {}
		arr = params[:str].split("_")
		attributes[:card_id] = arr[0]
		attributes[:reader_id] = arr[1]
		attributes[:strength] = arr[2]
		attributes[:logtime] = arr[3]
		@trace = Trace.new(attributes)
		@trace.save
	end

	def reload_page
		@cards = (0...100).to_a #for 100 cards. /change this when records are more.
		respond_to do |format|
  			format.js{}
		end
	end
end
