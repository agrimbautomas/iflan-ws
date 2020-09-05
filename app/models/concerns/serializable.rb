module Serializable
	def serialize(options = {})
		ActiveModelSerializers::SerializableResource.new(self, options).as_json
	end
end