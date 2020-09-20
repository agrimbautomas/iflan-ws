class GetStats < BaseInteractor

	def self.serialized
		get_stats = new
		get_stats.execute
	end

	def initialize
	end

	def execute
		serialized_stats
	end

	def serialized_stats
		{
				:tmp_hum => tmp_hum_stats,
				:noise => noise_stats
		}
	end
	

	def tmp_hum_stats
		last_tmp_hum_log = TmpHumLog.last
		serialize_tmp_hum last_tmp_hum_log
	end

	def serialize_tmp_hum last_tmp_hum_log
		{last: last_tmp_hum_log}
	end

	def noise_stats
		last_noise_log = NoiseLog.last
		serialize_noise last_noise_log
	end

	def serialize_noise last_noise_log
		{
				last: last_noise_log,
				avg_per_day: GetNoiseLogAvg.last_week
		}
	end

end
