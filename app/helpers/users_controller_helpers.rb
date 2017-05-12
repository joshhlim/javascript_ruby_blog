module UserControllerHelper
  def verify_authorship
    halt(404, erb(:'404')) if @user.nil?
  end
end

helpers UserControllerHelper
