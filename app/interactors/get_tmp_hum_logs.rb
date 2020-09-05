class GetTmpHumLogs < BaseInteractor
	def self.default
		new().execute
	end

	def initialize()
	end

	def execute
		get_tmp_hum_logs
	end

	private
	def get_tmp_hum_logs
		TmpHumLog.all.limit(100)
	end

end