class TenderNotifications < ActionMailer::Base
  default from: "no-reply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tender_notifications.succesfull_submission.subject
  #
  def succesfull_submission(offer)
    @greeting = "Χαίρετε"
    @user = User.find(offer.user_id)
    @offer = offer
    @procurement = Procurement.find(offer.procurement_id)

    mail to: @user.email, subject: '[E-Proc] Tender Submitted Succesfully'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tender_notifications.tender_updated.subject
  #
  def tender_updated
    @greeting = "Χαίρετε"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tender_notifications.procurement_changed.subject
  #
  def self.send_procurement_changed(procurement)
    @recipients = []
    procurement.offers.each { |off| @recipients << User.find(off.user_id).email }

    @recipients.each { |recipient| procurement_changed(recipient,procurement).deliver }
  end

  def procurement_changed(recipient, procurement)
    @procurement = procurement
    @greeting = "Χαίρετε"
    @recipient = recipient

    mail to: recipient, subject: '[E-Proc] Procurement change!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tender_notifications.tender_won.subject
  #
  def tender_won(offer)
    @greeting = "Χαίρετε"
    @offer = offer
    @user = offer.user

    mail to: @user.email, subject: "[E-Proc] Your Offer Won."
  end
end
