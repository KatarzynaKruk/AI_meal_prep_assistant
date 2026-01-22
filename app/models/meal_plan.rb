class MealPlan < ApplicationRecord
  belongs_to :user
  has_one :chat, dependent: :destroy
  after_create :build_meal_plan

  validates :goal, :system_prompt, :user, :diet, presence: true
  validates :additional_preferences, :meals_required, presence: true, allow_blank: true
  validates :additional_preferences, :meals_required, length: { maximum: 200 }


  private

  def build_meal_plan
    @chat = Chat.create(meal_plan: self, user: self.user)
    ruby_llm_chat = RubyLLM.chat
    response = ruby_llm_chat.with_instructions(self.system_prompt).ask("")
    Message.create(role: "assistant", content: response.content, chat: @chat)
  end
end

