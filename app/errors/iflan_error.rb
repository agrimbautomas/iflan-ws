class IflanError < StandardError
	attr_reader :error
	attr_reader :error_message
	attr_reader :status_code

	def initialize(error, error_message, status_code = 400)
		super "#{error}: #{error_message}"
		@error = error
		@error_message = error_message
		@status_code = status_code
	end
end