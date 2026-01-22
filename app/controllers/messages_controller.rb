class MessagesController < ApplicationController
  before_action :set_user
  before_action :set_chat

  def create
    # @chat = current_user.chats.find(params[:chat_id])
    # @meal_plan = @chat.meal_plan

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      build_conversation_history(ruby_llm_chat)
      response = ruby_llm_chat.with_instructions(@meal_plan.system_prompt).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      # @chat.generate_title_from_first_message
      # Message.create(content: response.content, chat: @chat)
      redirect_to user_meal_plan_chat_path(@meal_plan.user, @chat)
    else
       @messages = @chat.messages.order(created_at: :desc)
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history(ruby_llm_chat)
    @chat.messages.each do |message|
      ruby_llm_chat.add_message(
        role: message.role.to_sym,
        content: message.content
        )
    end
  end

  def set_user
    @user = current_user
  end

  def set_chat
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @chat = @meal_plan.chat || @meal_plan.build_chat
    @chat.save! if @chat.new_record?
    @messages = @chat.messages.order(created_at: :desc)
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
