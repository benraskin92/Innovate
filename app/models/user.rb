class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :challenges, dependent: :destroy
  has_many :solutions, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id"
  has_many :followed_challenges, through: :relationships, source: :challenge


  before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true  

  has_attached_file :profile_pic, :default_url => 'profile_pic_default.png'
	validates_attachment :profile_pic, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

def following_challenge?(challenge)
  relationships.find_by_followed_id(challenge.id)
end

def follow_challenge!(challenge)
  relationships.create!(followed_id: challenge.id)
end

def challenge_unfollow!(challenge)
  relationships.find_by_followed_id(challenge).destroy
end

end
