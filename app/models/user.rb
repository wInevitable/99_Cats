class User < ActiveRecord::Base
  
  validates :user_name, { :uniqueness => true }
  validates :user_name, :password_digest, :session_token, { :presence => true }
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
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
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by_username(username)
    user.try(:is_password?, password) ? user : nil
  end
  
end
