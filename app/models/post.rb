class Post
  include Mongoid::Document
  include AsJson
  define_as_json :simple_json, :only => [:_id]

  field :title, type: String
  field :body, type: String
  field :published, type: Mongoid::Boolean

  validates :title, presence: true
  validates :body, presence: true
end
