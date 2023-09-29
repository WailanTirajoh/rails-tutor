# frozen_string_literal: true

module Api
  module V1
    # Book API Resource
    class BooksController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: %i[create destroy]

      def index
        book = Book.ransack(params[:q])
                   .result.includes(:author)

        render json: BookSerializer.new(book)
      end

      def create
        author = Author.create!(author_params)
        book = Book.create(book_params.merge(author_id: author.id))

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content
      end

      private

      def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render status: :unauthorized
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
