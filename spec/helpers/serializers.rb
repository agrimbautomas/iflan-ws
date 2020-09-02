module Serializers
	def serialize(object, options = {})
		ActiveModelSerializers::SerializableResource.new(object, options).as_json
	end

	def serialize_lean(object)
		serialize object, { include: [] }
	end
end