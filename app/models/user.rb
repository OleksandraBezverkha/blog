# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  image                  :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities, dependent: :destroy
  attr_accessor :login
  devise :database_authenticatable, :confirmable,:registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,:authentication_keys => [:login]
  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            } # etc.
  validate :validate_username
  # attr_accessible :user_id, :name, :image, :remote_image_url
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  mount_uploader :image, ImageUploader
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      user = User.find_by_email(auth.info.email)
    end
    # Create the user if needed
    # if user.nil?
    #
    #   # Get the existing user by email if the provider gives us a verified email.
    #   # If no verified email was provided we assign a temporary email and ask the
    #   # user to verify it on the next step via UsersController.finish_signup
    #   email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
    #   email = auth.info.email if email_is_verified
    #   user = User.where(:email => email).first if email

      # Create the user if it's a new registration
    if user.nil?
      user = User.new(
          username: auth.info.name,
          #username: auth.info.nickname || auth.uid,
          email: auth.info.email,
          # email: "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      # if User.exists?(:email => user.email)
      #
      # else
        user.save!
      # end

    end
    # end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  # def login=(login)
  #   @login = login
  # end
  #
  # def login
  #   @login || self.email || self.username
  # end
  #
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     where(conditions.to_h).first
  #   end
  # end
end
