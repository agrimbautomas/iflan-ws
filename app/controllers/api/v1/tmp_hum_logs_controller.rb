class Api::V1::TmpHumLogsController < Api::V1::ApiController

	def create
		render_object create_tmp_hum_log
	end

	def index
		render_collection tmp_hum_logs
	end

	private
	def create_tmp_hum_log
		CreateUser.for company: current_company, params: tmp_hum_log_attributes
	end

	def tmp_hum_log_attributes
		params[:tmp_hum_log]&.permit!.to_h.symbolize_keys
	end

	def tmp_hum_logs
		GetUsers.for company: current_company
	end


end