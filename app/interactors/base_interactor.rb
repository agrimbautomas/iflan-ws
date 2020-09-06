class BaseInteractor
	include ErrorRaiser

	private
	def raise_invalid_tmp_hum_log_repository
		fail 'Invalid Tags\'s repository'
	end

	def raise_invalid_noise_log_repository
		fail 'Invalid Noise\'s repository'
	end

	def raise_invalid_user_repository
		fail 'Invalid Users\'s repository'
	end

end