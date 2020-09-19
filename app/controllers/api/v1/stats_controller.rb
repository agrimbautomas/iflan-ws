class Api::V1::StatsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token

	def index
		render_hash serialized_stats
	end

	private

	def serialized_stats
		GetStats.serialized
	end

end
