require "rails_helper"

RSpec.describe "User deletes post", type: :feature do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before do
    login_as(user, scope: :user)
    visit root_path
  end

  it "deletes the post successfully", js: true do
    accept_confirm do
      click_on "Delete post", match: :first
    end
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Post was successfully destroyed.")
    expect(page).not_to have_content(post.body)
  end
end
