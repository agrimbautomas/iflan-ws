class GetNoiseLogs < BaseInteractor
	def self.default
		new().execute
	end

	def initialize()
	end

	def execute
		get_noise_logs
	end

	private
	def get_noise_logs
		NoiseLog.all.limit(100)
	end

end