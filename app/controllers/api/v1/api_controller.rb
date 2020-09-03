class Api::V1::ApiController < ApplicationController
	include ResponseRenderer
	include FailureResponseRenderer


	#before_action :doorkeeper_authorize!
	#skip_before_action :verify_authenticity_token

	rescue_from ::IflanfError, with: :render_paper_chef_error
	rescue_from ::ActiveRecord::RecordInvalid, with: :render_invalid_record
	rescue_from ::ActiveRecord::RecordNotFound, with: :render_record_not_found
	rescue_from ::ArgumentError, with: :render_argument_error

	private

	def current_user
		@user ||= User.find doorkeeper_token.resource_owner_id rescue nil if doorkeeper_token
	end

	def current_company_id
		current_company.id
	end

	def current_company
		current_user.company
	end

	def is_paginated?
		page.present? and per_page.present?
	end

	def company_id
		params[:company_id]
	end

	def page
		params[:page]
	end

	def per_page
		params[:per_page]
	end

	def tag_id
		params[:tag_id]
	end

	def lot_quantity
		params[:lot_quantity]
	end

	def size
		params[:size]
	end

	def search_params
		params&.permit!.to_h.except(:page, :per_page, :controller, :action).deep_symbolize_keys
	end

	def user_not_authorized
		render_paper_chef_error(PaperChefForbiddenError.new)
	end

	def render_collection(collection, options = {})
		render_successful_response CollectionRenderer.new(collection, options).render
	end

	def render_object(object, options = {})
		render_successful_response ObjectRenderer.new(object, options).render
	end

	def render_hash(hash)
		render_successful_response({ response: hash })
	end

	def render_paper_chef_error(exception)
		render_failed_response exception.error, exception.error_message, exception.status_code
	end

	def render_record_not_found(exception)
		render_failed_response 'record_not_found', exception.message, 404
	end

	def render_invalid_record(exception)
		render_failed_response 'invalid_record', exception.record.errors.messages, 422
	end

	def render_argument_error(exception)
		render_failed_response 'argument_error', exception.message, 422
	end

	def render_successful_response(hash)
		render_response hash: hash, status: 200
	end

	def render_successful_html_response(html)
		render plain: html, content_type: 'text/html; charset=utf-8'
	end

	def validate_company_id
		raise PaperChefError.new 'invalid_company_id', "The company param must be 'me'" if company_id != 'me'
	end

	def render_deprecated_endpoint
		render_hash({ message: 'This endpoint has been deprecated' })
	end
end