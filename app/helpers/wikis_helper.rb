module WikisHelper
  def user_is_authorized_for_wiki?(wiki)
    current_user && (current_user == wiki.user || current_user.admin?)
  end

  def user_is_authorized_for_private_wikis(wiki)
    wiki.private == false || current_user && (current_user.premium? || current_user.admin?)
  end
end
