class Users::SessionsController < Devise::SessionsController
# Handles sign_in, sign_out automatically
protected

  def after_sign_in_path_for(resource)
    user_meal_plans_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
