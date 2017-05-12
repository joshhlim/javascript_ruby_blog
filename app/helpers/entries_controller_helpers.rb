module EntryControllerHelper
  def find_and_ensure_entry(id)
    entry = Entry.find_by(id: id)
    halt(404, erb(:'404')) if entry.nil?
    entry
  end
  def verify_login
    halt(404, erb(:'404')) if session['user_id'].nil?
  end
  def verify_user
    halt(404, erb(:'404')) if session['user_id'] != @entry.user.id
  end
end

helpers EntryControllerHelper
