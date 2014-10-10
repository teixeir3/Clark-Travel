# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      not null
#  password_digest        :string(255)      not null
#  session_token          :string(255)      not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  is_admin               :boolean          default(FALSE), not null
#  created_at             :datetime
#  updated_at             :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  is_active              :boolean          default(FALSE), not null
#  activation_token       :string(255)      default("INACTIVE"), not null
#  uid                    :string(255)
#  access_token           :string(255)
#  provider               :string(255)
#  position               :integer
#  title                  :string(255)
#  bio                    :text
#  work_phone             :string(255)
#  home_phone             :string(255)
#  mobile_phone           :string(255)
#  fax                    :string(255)
#

class User < ActiveRecord::Base
  extend ActiveModel::Callbacks
  
  attr_reader :password
  
  validates_confirmation_of :password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :session_token, presence: true, uniqueness: true
  validates :uid, uniqueness: {scope: :provider, if: :check_uid_by_provider}
  validates_format_of :work_phone, :mobile_phone, :home_phone, :fax, with: /\d/, allow_blank: true
  
  has_attached_file :avatar,
                    :styles => { :small => "160x200", :medium => "360x450>", :thumb => "100x100>" },
                    :default_url => ":style/missing.png",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  define_model_callbacks :create
  before_validation :ensure_session_token
  before_validation :set_temporary_password, on: :create
  before_create :set_activation_token
  
  has_many(
    :promotions,
    class_name: "Promotion",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )
  
  
  def name
    "#{first_name} #{last_name}"
  end
  
  ### Auth Methods ###
  
  def is_admin?
    is_admin
  end
  
  def send_password_reset
    self.password_reset_token = self.class.generate_unique_token_for_field(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    
    UserMailer.password_reset_email(self).deliver    
  end
  
  def activate!
    self.update_attribute(:active, true)
  end
  
  def set_activation_token
    self.activation_token = self.class.generate_unique_token_for_field(:activation_token)
  end
  
  def set_temporary_password
    self.password = self.class.generate_unique_token_for_field(:password_digest) unless self.password_digest
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    user.try(:is_password?, password) ? user : nil
  end


  def self.generate_session_token
    self.generate_unique_token_for_field(:session_token)
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def check_uid_by_provider
    uid || provider
  end
end
