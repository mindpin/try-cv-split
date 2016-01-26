class Book
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  field :published, type: Mongoid::Boolean

  has_many :comments

  validates :title, presence: true
  validates :body, presence: true
end
