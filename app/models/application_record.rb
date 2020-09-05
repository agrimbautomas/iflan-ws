class ApplicationRecord < ActiveRecord::Base
  include Serializable
  self.abstract_class = true

  def self.humanize_name
    name.underscore.split('_').join(' ').titleize
  end

  def self.underscore_name
    name.underscore
  end
end
