module ResponseRenderer
	def render_response(parameters = {})
		render json: parameters[:hash], adapter: :json, status: parameters[:status]
	end
end