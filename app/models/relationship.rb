class Relationship < ActiveRecord::Base
	belongs_to :user, foreign_key: "follower_id"
	belongs_to :challenge, foreign_key: "followed_id"
end
