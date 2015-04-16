require 'rails_helper'

RSpec.describe Document, :type => :model do

  it { should have_attached_file(:document) }
  it { should validate_attachment_content_type(:document).allowing("application/pdf") }
  it { should validate_attachment_size(:document).less_than(5.megabytes) }

end
