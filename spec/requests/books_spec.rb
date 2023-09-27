require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: '1984', author: 'Wailan Tirajoh')
      FactoryBot.create(:book, title: 'Testing', author: 'Jon Doe')
    end

    it 'should returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'should create a new book' do
      expect do
        post '/api/v1/books', params: { book: { title: 'The Killa', author: 'Wai' } }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: 'Wailan Tirajoh') }

    it 'should delete book by id' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
