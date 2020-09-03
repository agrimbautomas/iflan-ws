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
require 'rails_helper'

RSpec.describe TmpHumLog, type: :model do

  it { should respond_to(:humidity) }
  it { should validate_numericality_of(:humidity).is_less_than_or_equal_to(100) }

  it { should respond_to(:temperature) }
  it { should validate_numericality_of(:temperature).is_less_than_or_equal_to(100) }
	
end
