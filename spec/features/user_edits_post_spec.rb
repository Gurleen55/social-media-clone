require "rails_helper"

RSpec.describe "User edits a post", type: :feature, js: true do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, body: "This is a test post") }
  before do
    # create a user for testing
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  it "creates a post" do
    click_link "Edit post"
    expect(page).to have_current_path(root_path)
    fill_in "post_body", with: "Updated post"
    click_button "Update Post"
    expect(page).to have_current_path(root_path)
    expect(page).to have_content "Updated post"
  end
end
