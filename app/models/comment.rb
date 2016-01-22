class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body, type: String

  belongs_to :book

  validates :body, presence: true
end
