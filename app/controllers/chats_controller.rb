class ChatsController < ApplicationController
  before_action :set_meal_plan

  def index
  @chats = current_user.chats.includes(:meal_plan, :profile_information)
  end

  def new
    @chat = Chat.new
  end

  def create
    @meal_plan = current_user.meal_plans.find(params[:meal_plan_id])
    @chat = Chat.new
    @chat.meal_plan = @meal_plan
    @chat.user = current_user
    # @chat.profile_information_id = current_user.profile_information  #check if we need user or profile?

    if @chat.save
      redirect_to user_meal_plan_chat_path(current_user, @meal_plan)
    else
      @chats = @meal_plan.chats.where(user: current_user)
      render "meal_plans/show", status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:user_id])
    @meal_plan = current_user.meal_plans.find(params[:meal_plan_id])
    @chat = @meal_plan.chat
    @message = Message.new
    @messages = @chat.messages.order(:created_at)
  end


private

  def set_meal_plan
    @meal_plan = current_user.meal_plans.find(params[:meal_plan_id])
  end
end
