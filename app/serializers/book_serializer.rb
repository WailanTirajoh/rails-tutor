# frozen_string_literal: true

# Book Serializer
class BookSerializer
  include JSONAPI::Serializer
  # belongs_to :author
  attributes :title

  attribute :author do |book|
    AuthorSerializer.new(book.author).as_json['data']
  end
end
