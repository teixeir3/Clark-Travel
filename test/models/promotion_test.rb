# == Schema Information
#
# Table name: promotions
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  user_id              :integer          not null
#  highlight            :text
#  body                 :text
#  start_date           :date
#  expiration_date      :date
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
