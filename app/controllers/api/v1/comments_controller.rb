# frozen_string_literal: true

module Api
  module V1
    # CommentsController
    class CommentsController < ApplicationController
      before_action :set_post
      before_action :set_comment, only: %i[show update destroy]

      def index
        @comments = @post.comments
        render json: @comments
      end

      def show
        render json: @comment
      end

      def create
        @comment = @post.comment.new(comment_params)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = @post.comments.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
