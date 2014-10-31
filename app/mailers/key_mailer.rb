class KeyMailer < ActionMailer::Base
  default from: "user@example.com"

  def tender_encryption_key(user, key, salt)
    @key = key
    @salt = salt
    @user = user

    mail to: @user.email, subject: "[E-Proc Alpha] Thank you for your Tender"
  end
end