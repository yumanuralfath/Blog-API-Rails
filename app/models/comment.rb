class Comment
  include Mongoid::Document
  field :content, type: String

  belongs_to :post
  validates :content, presence: true
end
