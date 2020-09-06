# == Schema Information
#
# Table name: tmp_hum_logs
#
#  id          :bigint(8)        not null, primary key
#  humidity    :float(24)
#  temperature :float(24)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class TmpHumLog < ApplicationRecord

	validates :temperature, presence: true, unless: :humidity
	validates :temperature, allow_blank: true, numericality: {only_float: true, less_than_or_equal_to: 100}

	validates :humidity, presence: true, unless: :temperature
	validates :humidity, allow_blank: true, numericality: {only_float: true, less_than_or_equal_to: 100}

end