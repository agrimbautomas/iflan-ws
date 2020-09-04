class ObjectRenderer < Renderer
	private
	def render_successful_response
		response
	end

	def object_serialization
		object.serialize @options
	end

	def object_serialization_error
		serialization_error 'The object provided must not be a collection'
	end

	def validate
		super
		raise object_serialization_error if is_a_collection?
	end

	def object
		ensure_serializability
		@object
	end

	def ensure_serializability
		make_serializable unless serializable?
	end

	def serializable?
		@object.is_a? Serializable
	end

	def make_serializable
		@object.singleton_class.instance_exec do
			include Serializable
		end
	end
end