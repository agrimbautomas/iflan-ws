class CreateTmpHumLog < BaseInteractor
	def self.for(params:)
		new(params: params, tmp_hum_log_repository: TmpHumLogRepository.new).execute
	end

	def initialize(params:, tmp_hum_log_repository:)
		raise_invalid_tmp_hum_log_repository unless tmp_hum_log_repository
		@params = params
		@tmp_hum_log_repository = tmp_hum_log_repository
	end

	def execute
		validate_params
		create_tmp_hum_log
	end

	private

	def create_tmp_hum_log
		@tmp_hum_log_repository.create @params
	end

	def validate_params
		invalid :params, 'The params provided must not be nil' if @params.blank?
	end
end