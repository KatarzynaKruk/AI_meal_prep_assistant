class MealPlansController < ApplicationController

  # resources :meal_plans, only: [:create, :index, :show]

  def index
    @meal_plans = current_user.meal_plans
  end

  def new
    @meal_plan = MealPlan.new()
  end

  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    if @meal_plan.save!
      redirect_to meal_plans(current_user)
    else
      render :new, :unprocessable_entity
    end
  end

  def show
    # will depend on chat and messages
  end

  def destroy

  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(
      :plan_title,
      :goal,
      :additional_preferences,
      :system_prompt,
      :diet,
      :meals_required
    )
  end
end
