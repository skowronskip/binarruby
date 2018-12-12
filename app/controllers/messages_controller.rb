class MessagesController < ApplicationController
  before_action	:authenticate_user!
  def index
    #@messages_array = Message.all.page(params[:page]).order(created_at: :desc)
    @messages = Message.all.page(params[:page]).order(created_at: :desc)
    @messages_array = @messages.map {|message| MessagePresenter.new(message)}
  end

  def show
    @message = MessagePresenter.new(Message.find(params[:id]))
    @comments = @message.comments.order(created_at: :desc)
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
    authorize(@message)
  end

  def update 
    @message = Message.find(params[:id])
    authorize(@message)
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
    authorize(message)
    message.destroy
    flash[:notice] = "Message has been deleted."
    redirect_to messages_path
  end

  private

  def message_params 
    params.require(:message).permit(:content, :author, :photo)
  end
end
