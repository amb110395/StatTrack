class UserMailer < ActionMailer::Base
  default from: "donotreply@stattrack.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "StatTrack: Password Reset"
  end
end
