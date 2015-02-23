require "rails_helper"

RSpec.describe TenderNotifications, :type => :mailer do

  let(:offer) { FactoryGirl.build(:offer) }
  let(:procurement) { FactoryGirl.create(:procurement) }

  describe "succesfull_submission" do
    let(:mail) { TenderNotifications.succesfull_submission(offer) }

    it "renders the headers" do
      expect(mail.subject).to match("Submitted Succesfully")
      expect(mail.to).to eq([offer.user.email])
      expect(mail.from).to eq(["no-reply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(offer.user.name)
    end
  end

  # describe "tender_updated" do
  #   let(:mail) { TenderNotifications.tender_updated }

  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Tender updated")
  #     expect(mail.to).to eq([user.email])
  #     expect(mail.from).to eq(["no-reply@example.com"])
  #   end

  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Χαίρετε")
  #   end
  # end

  describe "procurement_changed" do
    let(:mail) { TenderNotifications.procurement_changed(user.email, procurement) }
    let(:user) { FactoryGirl.build(:user, :supplier) }

    it "renders the headers" do
      expect(mail.subject).to match("Procurement change")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@example.com"])
    end

    it "renders the body" do
      expect(mail.text_part.body.decoded).to match("Η Προκύρηξη")
    end
  end

  describe "tender_won" do
    let(:mail) { TenderNotifications.tender_won(offer) }

    it "renders the headers" do
      expect(mail.subject).to match("Offer Won")
      expect(mail.to).to eq([offer.user.email])
      expect(mail.from).to eq(["no-reply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(offer.user.name)
    end
  end

end
