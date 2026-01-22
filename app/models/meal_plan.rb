class MealPlan < ApplicationRecord
  belongs_to :user
  has_one :chat, dependent: :destroy
  after_create :build_meal_plan

  validates :goal, :system_prompt, :user, :diet, presence: true
  validates :additional_preferences, :meals_required, presence: true, allow_blank: true
  validates :additional_preferences, :meals_required, length: { maximum: 200 }


  private

  def build_meal_plan
    # @message = Message.new(message_params)
    # @message.chat = @chat
    # @message.role = "user"
    @chat = Chat.create(meal_plan: self, user: self.user)

    # if @message.save
      ruby_llm_chat = RubyLLM.chat
      # build_conversation_history(ruby_llm_chat)
      response = ruby_llm_chat.with_instructions(self.system_prompt).ask("")
      Message.create(role: "assistant", content: response.content, chat: @chat)

      # @chat.generate_title_from_first_message
      # Message.create(content: response.content, chat: @chat)
      # redirect_to user_meal_plan_chat_path(self.user, @chat)
    # else
      #  @messages = @chat.messages.order(created_at: :desc)
      # render "chats/show", status: :unprocessable_entity
  end
end

