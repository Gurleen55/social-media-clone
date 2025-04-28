require "rails_helper"

RSpec.describe "User creates a comment", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    driven_by :selenium_chrome_headless
    login_as(user, scope: :user)
    visit root_path
  end

  it "allows a user to create a comment" do
    click_link "New Comment"
    expect(page).to have_current_path(post_comments_path(post))

    within("[data-testid='new_comment']") do
      fill_in "comment[body]", with: "This is a test comment"
      click_button "Create Comment"
    end

    expect(page).to have_content("Comment was successfully created.")
    expect(page).to have_content("This is a test comment")
  end
end
