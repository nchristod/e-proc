require 'rails_helper'

RSpec.describe Document, :type => :model do

  it { should have_attached_file(:document) }
  it { should validate_attachment_content_type(:document).allowing("application/pdf") }
  it { should validate_attachment_size(:document).less_than(5.megabytes) }

  describe "#decrypt" do
    it "decrypts the file content" do
      skip "test not implemented"
    end

    it "restores the original file" do
      skip "test not implemented"
    end
  end
end
