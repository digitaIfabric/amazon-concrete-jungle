class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  validates :password_digest, length: { minimum: 4 }
  validates :email, uniqueness: { case_sensitive: false}
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.lstrip.rstrip)
    puts "The user is: ", user
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
