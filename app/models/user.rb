class User < ActiveRecord::Base

  if Blacklight::Utils.needs_attr_accessible?
    # Setup accessible (or protected) attributes for your model
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me)
    end
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    email
  end
end
