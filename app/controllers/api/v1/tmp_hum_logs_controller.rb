class Api::V1::TempHumLogsController < Api::V1::ApiController
	def create
		authorize User, :create_user?
		render_object create_user
	end

	def destroy
		authorize User, :archive_user?
		render_object archive_user
	end

	def index
		authorize User, :show_users?
		render_collection users
	end

	def show
		validate_user_id
		render_object current_user
	end

	def update
		authorize user, :update_user?
		render_object update_user
	end

	private
	def archive_user
		validate_company_id
		DeleteUser.with user_id: user_id, current_user: current_user
	end

	def create_user
		validate_company_id
		CreateUser.for company: current_company, params: user_attributes
	end

	def update_user
		validate_company_id
		UpdateUser.with company: current_company, user_id: user_id, params: user_attributes
	end

	def users
		validate_company_id
		GetUsers.for company: current_company
	end

	def user
		GetModel.new(id: user_id, repository: UserRepository.new).execute
	end

	def user_id
		params[:id]
	end

	def user_attributes
		params[:user]&.permit!.to_h.symbolize_keys
	end

	def validate_user_id
		raise PaperChefError.new 'invalid_user_id', "The user param must be 'me'" if user_id != 'me'
	end
end