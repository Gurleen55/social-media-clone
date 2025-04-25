require "rails_helper"

RSpec.describe "User unfollows another user", type: :system, js: true do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      driven_by :selenium_chrome_headless
      login_as(user, scope: :user)
      visit root_path
      click_link "Find friends"
    end

    it "it should allow a user to unfollow another user" do
      expect(page).to have_current_path(users_path)

      within("[data-testid='user_#{other_user.id}']") do
        click_button "Follow"
        expect(page).to have_button("Unfollow")
      end
      user.reload
      expect(user.following.reload).to include(other_user)

      within("[data-testid='user_#{other_user.id}']") do
        click_button "Unfollow"
        expect(page).to have_button("Follow")
      end
      user.reload
      expect(user.following.reload).not_to include(other_user)
  end
end
