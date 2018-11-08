class CommentsController < ApplicationController
    def index
      @comments = Comment.all
    end
  
    def show
      @comment = Comment.find(params[:id])
    end
  
    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      redirect_to comments_path
    end
  end