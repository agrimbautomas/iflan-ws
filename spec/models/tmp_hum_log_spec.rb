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
  pending "add some examples to (or delete) #{__FILE__}"
end
