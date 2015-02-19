# == Schema Information
#
# Table name: booking_categories
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  position             :integer
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer          not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  display              :boolean          default(TRUE), not null
#

class BookingCategory < ActiveRecord::Base
  validates :title, :user, presence: true
  
  has_attached_file :picture,
                    :styles => { :small => "160x86", :medium => "700x332>", :large => "748x348", :thumb => "100x100>" },
                    :default_url => ":style/resources_air_delays.gif",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  
  has_many(
    :bookings,
    class_name: "Booking",
    foreign_key: :category_id,
    primary_key: :id,
    inverse_of: :category
  )
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :booking_categories
  )
  
  def self.all_active
    self.all(order: "position")
  end
  
end
