# == Schema Information
#
# Table name: promotions
#
#  id                    :integer          not null, primary key
#  title                 :string(255)      not null
#  user_id               :integer          not null
#  highlight             :text
#  body                  :text
#  start_date            :date
#  expiration_date       :date
#  created_at            :datetime
#  updated_at            :datetime
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#  position              :integer          default(0), not null
#  display               :boolean          default(TRUE), not null
#  facebook_publish      :boolean          default(FALSE), not null
#  carousel_display      :boolean          default(FALSE), not null
#  facebook_published_at :datetime
#  facebook_id           :string(255)
#

require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
