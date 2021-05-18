class LogInUser < Interactor
  validates :email, :password, presence: true

  def self.with(email:, password:)
    log_in_user = new(email: email, password: password)
    log_in_user.execute
  end

  def execute
    @user = User.find_for_database_authentication(:email => email.downcase)
    validate_app_user
    log_in
  end

  private

  def validate_app_user
    forbidden :user, "The user doesn't exist" unless @user.present?
  end

  def log_in
    if @user && @user.valid_for_authentication? { @user.valid_password? password }
      @user
    end
  end

end