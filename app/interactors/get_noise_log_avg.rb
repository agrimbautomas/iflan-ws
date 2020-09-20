class GetNoiseLogAvg < BaseInteractor

	def self.last_week
		get_stats = new
		get_stats.execute
	end

	def initialize
	end

	def execute
		noise_log_avg
	end

	def noise_log_avg
		total = NoiseLog.where('created_at > ?', 1.week.ago).group("date_format(created_at, '%Y%m%d %H')").count
		(total.count / 7).to_f
	end
	

end
