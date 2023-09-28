require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET index' do
  end

  describe 'POST create' do
    context 'missing authorization header' do
      it 'returns a 401' do
        post :create, params: {}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'missing authorization header' do
      it 'returns a 401' do
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
