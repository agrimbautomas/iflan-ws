class Renderer
	def initialize(object, options)
		@object = object
		@options = options || {}
	end

	def render
		validate
		render_successful_response
	end

	private
	def serialization_error(error_message)
		fail error_message
	end

	def is_a_collection?
		@object.is_a? Array or @object.respond_to? :to_ary
	end

	def response
		{ response: object_serialization }
	end

	def validate
		fail 'The object provided must not be nil' if @object.nil?
	end
end