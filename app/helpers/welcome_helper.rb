module WelcomeHelper
  def user_is_standard_or_upgrading_member
    user_signed_in? && (current_user.role == 'standard' || current_user.role == 'upgrading')
  end
end
