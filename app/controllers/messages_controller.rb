class MessagesController < ApplicationController
  SYSTEM_PROMPT = current_user.meal_plans.system_prompt
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
    @chat = current_user.chats.find(params[:chat_id])
    @meal_plan = @chat.meal_plan

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

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
