require Rails.root.join('spec/support/features/session_helpers.rb')

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
