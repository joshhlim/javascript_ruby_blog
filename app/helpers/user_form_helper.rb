module UserFormHelpers
  def submit_button_value(user)
    user.persisted? ? "Update Vegan" : "New Vegan"
  end

  def user_action(user)
    user.persisted? ? "/users/#{user.id}" : "/users"
  end
end

helpers UserFormHelpers
