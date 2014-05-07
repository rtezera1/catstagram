require 'spec_helper'

feature 'user creates meow for a post', %q{
  As a user
  I want to create a Meow for a post
  So that I can tell others that I like the post
} do 

  # Acceptance Criteria

  # - I must be signed in to meow at a post
  # - I should see the current meow count
  # - When I meow, I should see the meow count go
  # - I cannot Meow at the same Post twice

  let!(:post) { FactoryGirl.create(:post) }

  context 'as an authenticated user' do 
    before(:each) do 
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit root_path
    end

    scenario 'user creation a Meow for a post' do 
      click_button 'Meow'

      expect(page).to have_content '1 Meow'
      expect(page).to have_content 'We heard your Meow!'
    end

    scenario 'user cannot Meow a second time at a Post' do 
      click_button 'Meow'

      expect(page).to_not have_button "Meow", expect: true
    end

    scenario 'unauthenticated user cannot create a Meow' do 
      visit root_path
      expect(page).to_not have_button 'Meow'
    end

  end
end
