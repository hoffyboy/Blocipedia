module WikisHelper
  def user_is_authorized_for_wiki?(wiki)
    current_user && (current_user == wiki.user || current_user.admin?)
  end

  def user_is_admin_or_wiki_owner(wiki)
    current_user.admin? || current_user == wiki.user
  end
end
