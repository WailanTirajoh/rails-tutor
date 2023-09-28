# frozen_string_literal: true

module Api
  module V1
    # Book API Resource
    class BooksController < ApplicationController
      def index
        render json: BookSerializer.new(Book.includes(:author)).serializable_hash.to_json
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

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
