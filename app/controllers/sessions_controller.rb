class SessionsController < Devise::SessionsController

  def destroy
    if current_user != true_user
      stop_impersonating_user
      redirect_to root_path
    else
      super
    end
  end

end
