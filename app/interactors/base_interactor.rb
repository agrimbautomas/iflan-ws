class BaseInteractor
	include ErrorRaiser

	private
	def raise_invalid_address_repository
		fail 'Invalid Adddresses\'s repository'
	end

	def raise_invalid_company_repository
		fail 'Invalid Company\'s repository'
	end

	def raise_invalid_component_repository
		fail 'Invalid Components\'s repository'
	end

	def raise_invalid_contact_repository
		fail 'Invalid Contacts\'s repository'
	end

	def raise_invalid_custom_price_repository
		fail 'Invalid Custom Prices\'s repository'
	end

	def raise_invalid_discount_repository
		fail 'Invalid Discounts\'s repository'
	end

	def raise_invalid_finished_good_repository
		fail 'Invalid Finished Goods\'s repository'
	end

	def raise_invalid_finished_good_for_sale_reposiotry
		fail 'Invalid Finished Good For Sales\'s repository'
	end

	def raise_invalid_ingredient_repository
		fail 'Invalid Ingredients\'s repository'
	end

	def raise_invalid_order_repository
		fail 'Invalid Product\'s repository'
	end

	def raise_invalid_product_repository
		fail 'Invalid Product\'s repository'
	end

	def raise_invalid_tag_repository
		fail 'Invalid Tags\'s repository'
	end

	def raise_invalid_user_repository
		fail 'Invalid Users\'s repository'
	end

	def raise_invalid_work_order_repository
		fail 'Invalid Work Orders\'s repository'
	end

	def raise_invalid_repository
		fail 'Invalid repository'
	end
end