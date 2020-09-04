class LogInUser < BaseInteractor
	def self.with(email:, password:)
		new(email: email, password: password, user_repository: UserRepository.new).execute
	end

	def initialize(email:, password:, user_repository:)
		raise_invalid_user_repository unless user_repository
		@email = email
		@password = password
		@user_repository = user_repository
	end

	def execute
		validate_email
		log_in_user
		user
	end

	private
	def log_in_user
		invalid :password, 'Invalid password' unless user.valid_password? @password
	end

	def user
		@user ||= @user_repository.find_by email: @email, deleted_at: nil
	end

	def validate_email
		invalid :email, 'Invalid email' unless user.present?
	end
end