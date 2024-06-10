class Post
  include Mongoid::Document
  field :title, type: String
  field :content, type: String

  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
