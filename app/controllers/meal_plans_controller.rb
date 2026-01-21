class MealPlansController < ApplicationController
  before_action :set_user
  # resources :meal_plans, only: [:create, :index, :show]

  def index
    @meal_plans = @user.meal_plans
    @profile_information = @user.profile_information
  end

  def new
    @meal_plan = @user.meal_plans.build()
    @profile_information = @user.profile_information
  end

  def create
    @profile_information = @user.profile_information
    @meal_plan = @user.meal_plans.build(meal_plan_params.except(:system_prompt))

    @meal_plan.system_prompt = build_system_prompt(@meal_plan, @profile_information)

    if @meal_plan.save
      redirect_to user_meal_plans_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    @chats = @meal_plan.chats.where(user: current_user)
  end

  def destroy

  end

  def build_system_prompt(meal_plan, profile)
    plan_restrictions_text = if profile.restrictions.present?
      "I have #{profile.restrictions} restrictions in the meal plan and these are non-negotiable"
    else
      "I have no restrictions"
    end

    meals_required_text = if meal_plan.meals_required.present?
      "I would like #{meal_plan.meals_required} to be included in the plan"
        else
          "I would like 3 meals (breakfast, lunch, dinner) to be planned for one whole week"
        end

    additional_preferences_text = if meal_plan.additional_preferences.present?
      "I would like #{meal_plan.additional_preferences} to be included in the plan"
        else
          "I have no further considerations for the meal plan"
        end

    age = Date.current.year - profile.date_of_birth.year

    system_prompt =
      "You are a experienced nutritionist helping me with meal planning.
      I am a #{age} year old #{profile.gender}.
      My goal is to #{meal_plan.goal} and my diet is #{meal_plan.diet}.
      My current weight is #{profile.weight} and my height is #{profile.height}.
      #{plan_restrictions_text}.
      Additionally #{meals_required_text} and #{additional_preferences_text}.
      Return a concise meal plan and supporting shopping list.  The meal plan should be segregated by days and meals.
      The shopping list should have clearly marked what recipe each ingredient is intended for and be segregated by common supermarket sections.
      The return should be in markdown format.
      Additionally ask me afterwards if there are any further adjustments to the plan I would like based on the output you provide."
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

  def set_user
    @user = current_user
  end
end
