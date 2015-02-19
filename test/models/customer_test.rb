# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  street       :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :integer
#  home_phone   :string(255)
#  alt_phone    :string(255)
#  mobile_phone :string(255)
#  email        :string(255)
#  birth_date   :date
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
