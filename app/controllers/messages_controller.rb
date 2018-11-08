class MessagesController < ApplicationController
  before_action	:authenticate_user!
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
    @comments = @message.comments
  end

  def new 
    @message = Message.new
  end

  def create 
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to @message
    else
      render :new
    end
  end

  def edit 
    @message = Message.find(params[:id])
    if @message.user != current_user
      redirect_to message_path
    end
  end

  def update 
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message
    else
      render :edit
    end
  end

  def destroy
    message = Message.find(params[:id])
    if message.user == current_user
      message.destroy
    end
    redirect_to messages_path
  end

  private

  def message_params 
    params.require(:message).permit(:content, :author)
  end
end
