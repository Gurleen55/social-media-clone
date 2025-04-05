require "rails_helper"

RSpec.describe "User creates a post", type: :feature do
  before do
    # create a user for testing
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    visit new_post_path
  end

  it "creates a post" do
    fill_in "post[body]", with: "This is a test post"
    click_button "Create Post"
    expect(page).to have_content "Your Feed"
    expect(page).to have_content "This is a test post"
  end
end
