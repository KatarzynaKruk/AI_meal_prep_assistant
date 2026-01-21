class ProfileInformationsController < ApplicationController
  before_action :set_user

  # part of the onboarding process
  #

  def new
    @profile_information = @user.build_profile_information
  end

  def create
    @profile_information = @user.build_profile_information(profile_information_params)

      if @profile_information.save
        redirect_to user_meal_plans_path(current_user), notice: "Profile information created successfully."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # GET /users/:user_id/profile_information/:id/edit
  def edit
    @profile_information = current_user.profile_information
  end

  # PATCH /users/:user_id/profile_information/:id
  def update
    @profile_information = current_user.profile_information
    if @profile_information.update(profile_information_params)
      redirect_to edit_user_profile_information_path(@user), notice: "Profile information updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_information_params
    params.require(:profile_information).permit(
      :name,
      :height,
      :weight,
      :gender,
      :restrictions,
      :conditions,
      :date_of_birth
    )
  end
end

# string "name"
#     t.float "height"
#     t.float "weight"
#     t.text "restrictions"
#     t.string "conditions"
#     t.date "date_of_birth"
#     t.bigint "user_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.string "gender"
