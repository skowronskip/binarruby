class MessagesController < ApplicationController
  before_action	:authenticate_user!
  def index
    @messages = Message.all.sort {|m1,m2| m2.created_at <=> m1.created_at}
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
      flash[:notice] = "Message has been added."
      redirect_to @message
    else
      flash[:alert] = "Error occured, try again."
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
      flash[:notice] = "Message has been edited."
      redirect_to @message
    else
      flash[:alert] = "Error occured, try again." 
      render :edit
    end
  end

  def destroy
    message = Message.find(params[:id])
    if message.user == current_user
      message.destroy
    end
    flash[:notice] = "Message has been deleted."
    redirect_to messages_path
  end

  private

  def message_params 
    params.require(:message).permit(:content, :author)
  end
end
