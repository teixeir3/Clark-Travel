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
  validates :start_date, presence: true
  validates :expiration_date, presence: true, date: { after: lambda { |e| e.start_date}, message: "Must proceed the start date." }
  validates :title, :user, presence: true
  
  has_attached_file :picture,
                    :styles => { :small => "160x200", :medium => "700x332>", :large => "760x360", :thumb => "100x100>" },
                    :default_url => ":style/promotion_missing.png",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :promotions
  )
  
  def self.all_active
    self.where("current_date between start_date and expiration_date")
  end
end
