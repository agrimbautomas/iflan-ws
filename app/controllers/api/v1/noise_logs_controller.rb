class Api::V1::NoiseLogsController < Api::V1::ApiController

	def create
		render_object create_noise_log
	end

	private
	def create_noise_log
		CreateNoiseLog.for params: noise_log_attributes
	end

	def noise_log_attributes
		params[:noise_log]&.permit!.to_h.symbolize_keys
	end

	def noise_logs
		GetNoiseLogs.default
	end

end