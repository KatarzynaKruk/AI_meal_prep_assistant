class ProfileInformationsController < ApplicationController
  before_action :set_user

  def create
    @profile_information = @user.profile_information.new(profile_information_params)

    if @profile_information.save
      redirect_to meal_plans(current_user), notice: "Profile information created successfully."
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
    @profile_informations = current_user.profile_information
    if @profile_information.update(profile_information_params)
      redirect_to edit_profile_information_path,
      notice: "Profile information updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_information_params
    params.require(:profile_information).permit(
      :name,
      :height,
      :weight,
      :restrictions,
      :conditions,
      :date_of_birth
    )
  end
end
