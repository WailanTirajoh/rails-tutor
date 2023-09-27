# frozen_string_literal: true

module Api
  module V1
    # Book API Resource
    class BooksController < ApplicationController
      def index
        render json: BookSerializer.new(Book.includes(:author)).serializable_hash.to_json
      end

      def create
        book = Book.create(book_params)

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

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
