class ChatsController < ApplicationController
  def index
  @chats = current_user.chats_includes(:meal_plan, :profile_information)
  end

  def new
    @chat = Chat.new
  end

  def create
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @chat = Chat.new
    @chat.meal_plan = @meal_plan
    @chat.user = current_user
    @chat.profile_information = current_user.profile_information  #check if we need user or profile?

    if @chat.save
      redirect_to chat_path(@chat)
    else
      @chats = @meal_plan.chats.where(user: current_user)
      render "meal_plans/show"
    end
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end
end
