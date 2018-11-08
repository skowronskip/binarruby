class CommentsController < ApplicationController
    def index
      @comments = Comment.all
    end

    def new 
      @comment = Comment.new
      @comment.message_id = Message.find(params[:message]).id
    end
  
    def show
      @comment = Comment.find(params[:id])
    end

    def create 
      @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to @comment
      else
        render :new
      end
    end
  
    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      redirect_to comments_path
    end

    private

    def comment_params 
      params.require(:comment).permit(:content, :author, :message_id)
    end
  end