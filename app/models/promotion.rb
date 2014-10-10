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

class Promotion < ActiveRecord::Base
  
  
  has_attached_file :picture,
                    :styles => { :small => "160x200", :medium => "360x450>", :thumb => "100x100>" },
                    :default_url => ":style/missing.png",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )
end
