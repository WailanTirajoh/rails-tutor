require 'rails_helper'

describe 'Books API', type: :request do
  let!(:author) { FactoryBot.create(:author, first_name: 'Wailan', last_name: 'Tirajoh', age: 26) }
  let!(:user) { FactoryBot.create(:user, password: 'Password1') }
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w' }

  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: '1984', author:)
      FactoryBot.create(:book, title: 'Testing', author:)
    end

    it 'should return all books' do
      get '/api/v1/books'

      expect(Book.count).to eq(2)
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)
      expect(json_body['data'].size).to eq(2)
      expect(json_body['data'][0]['attributes']['title']).to eq('1984')
    end
  end

  describe 'POST /books' do
    it 'should create a new book' do
      expect do
        post '/api/v1/books', params: {
          book: { title: 'The Killa' },
          author: { first_name: 'Wailan', last_name: 'Tirajoh', age: 26 }
        }, headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(2)
    end
  end

  describe 'DELETE /books/' do
    let!(:book) do
      FactoryBot.create(:book, title: '1984', author_id: author.id)
    end

    it 'should delete book by id' do
      expect do
        delete "/api/v1/books/#{book.id}",
               headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
