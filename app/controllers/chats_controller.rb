class ChatsController < ApplicationController

  def index
    @chats = current_user.chats_includes(:meal_plan, :profile_information)
  end

  def new
    @chat = Chat.new
  end

  def show
    render @chat, status: :ok
  end

  def create
    @meal_plan = Meal_plan.find(id: params[:meal_plan_id])
    @chat = Chat.new
    @chat.meal_plan = @meal_plan
    @chat.profile = current_user.profile_information #check if we need user or profile?

    if @chat.save
      redirect_to chat_path
    else
      render #def path
  end
