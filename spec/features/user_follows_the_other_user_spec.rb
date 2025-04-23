require "rails_helper"

RSpec.describe "User follows another user", type: :feature, js: true do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it "it should allow a user to follow another user" do
      click_link "Find friends"
      expect(page).to have_current_path(users_path)

      within("[data-testid='user_#{other_user.id}']") do
        click_button "Follow"
      end
      expect(page).to have_selector("button", text: "Unfollow", wait: 5)
      user.reload
      expect(user.following.reload).to include(other_user)
  end
end
