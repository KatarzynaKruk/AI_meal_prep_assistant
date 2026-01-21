class MessagesController < ApplicationController
  before_action :set_user
  before_action :set_chat

  # SYSTEM_PROMPT = @user.meal_plans.system_prompt
  # def index
  #   @chats = current_user.chats.includes(:meal_plan, :profile_information)
  # end

  # def new
  #   @chat = Chat.new
  # end

  # def show
  #   render @chat, status: :ok
  # end

  def create
    # @chat = current_user.chats.find(params[:chat_id])
    # @meal_plan = @chat.meal_plan

    @message = Message.new(message_params)
    @message.chat = @chat
    # @message.role = "user"
    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(@meal_plan.system_prompt).ask(@message.content)
      # Message.create(role: "assistant", content: response.content, chat: @chat)
      Message.create(content: response.content, chat: @chat)
      redirect_to user_meal_plan_chat_path(@meal_plan.user, @chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_chat
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @chat = @meal_plan.chat
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def challenge_context
    "Here is the context of the challenge: #{@meal_plan.content}."
  end

  def instructions
    [SYSTEM_PROMPT, challenge_context].compact.join("\n\n")
  end
end
