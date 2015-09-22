class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :solutions

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_attached_file :attachment
	validates_attachment :attachment, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

	def self.search(search)
		if search 
			where 'title LIKE ?', "%#{search}%"
		else
			puts 'No results'
		end
	end

end
