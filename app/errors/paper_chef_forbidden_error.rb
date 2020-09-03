class IflanForbiddenError < IflanError
	def initialize
		error = 'forbidden'
		error_message = "You don't have permission to perform this action"
		super error, error_message, 403
	end
end