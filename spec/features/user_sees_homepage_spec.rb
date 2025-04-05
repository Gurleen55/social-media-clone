require "rails_helper"

RSpec.describe "Homepage", type: :feature do
  before do
    # create a user for testing
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    visit root_path
  end

  it "displays the homepage" do
    expect(page).to have_css("h3", text: "Your Feed")
  end
end
