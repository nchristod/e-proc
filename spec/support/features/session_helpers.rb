module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      check 'I agree to the Terms of Service.'
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      # click_button 'Sign in'
      page.find("html body main.container-fluid div.authform form#new_user.new_user input.button.right").click
    end
  end
end
