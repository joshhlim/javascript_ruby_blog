module UserFormHelpers
  def submit_button_value(user)
    user.persisted? ? "Update Vegan" : "New Vegan"
  end

  def user_action(user)
    p user.inspect
    user.id ? "/users/#{user.id}" : "/login"
  end
end

helpers UserFormHelpers
