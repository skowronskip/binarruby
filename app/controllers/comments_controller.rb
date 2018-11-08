class CommentsController < ApplicationController
    def index
      message_id = params[:message_id]
      if(!message_id.nil?)
        @comments = Comment.where(message_id: message_id)
      else
        @comments = Comment.all
      end
    end

    def new 
      @comment = Comment.new
      @comment.message_id = Message.find(params[:message_id]).id
    end
  
    def show
      @comment = Comment.find(params[:id])
    end

    def create 
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @comment
      else
        render :new
      end
    end

    def edit 
      @comment = Comment.find(params[:id])
      if @comment.user != current_user
        redirect_to comment_path
      end
    end

    def update 
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        redirect_to @comment
      else
        render :edit
      end
    end
  
    def destroy
      comment = Comment.find(params[:id])
      if comment.user == current_user 
        comment.destroy
      end
      redirect_to comments_path
    end

    private

    def comment_params 
      params.require(:comment).permit(:content, :author, :message_id)
    end
  end