class CreateNoiseLog < BaseInteractor
	def self.for(params:)
		new(params: params, noise_log_repository: NoiseLogRepository.new).execute
	end

	def initialize(params:, noise_log_repository:)
		raise_invalid_noise_log_repository unless noise_log_repository
		@params = params
		@noise_log_repository = noise_log_repository
	end

	def execute
		validate_params
		create_noise_log
	end

	private

	def create_noise_log
		@noise_log_repository.create @params
	end

	def validate_params
		invalid :params, 'The params provided must not be nil' if @params.blank?
	end
end