class BaseRepository
	include ErrorRaiser

	def archive(id)
		find(id).archive!
	end

	def destroy!(id)
		find(id).destroy!
	end

	def find(id, should_include_nested_objects = true)
		klass.find id
	end

	def update!(**kwargs)
		find(kwargs[:id]).update! kwargs.except(:id)
	end

	def all
		klass.all
	end

	def create(kwargs)
		klass.create! kwargs
	end

	def new_with(**kwargs)
		klass.new kwargs
	end

	def where(**kwargs)
		klass.where kwargs
	end

	def save(obj)
		obj.save!
	end

	def transaction( &a_block )
		ActiveRecord::Base.transaction( &a_block )
	end

	def unarchive(id)
		find(id).update! deleted_at: nil
	end

	private
	def klass
		self.class.name.gsub(/Repository$/, '').constantize
	end
end