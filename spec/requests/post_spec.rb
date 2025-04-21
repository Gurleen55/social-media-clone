require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "returns http success" do
      get "/posts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /posts/:id/edit" do
    let(:owner) { create(:user) }
    let(:non_owner) { create(:user) }
    let(:post) { create(:post, user: owner) }

    context "when the user is the owner of the post" do
      before do
        login_as(owner, scope: :user)
        get edit_post_path(post)
      end

      it "allows access to the edit page" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is not the owner of the post" do
      before do
        login_as(non_owner, scope: :user)
        get edit_post_path(post)
      end

      it "redirects to the posts index page" do
        expect(response).to redirect_to(posts_path)
      end

      it "sets an alert message" do
        follow_redirect!
        expect(flash[:alert]).to eq("You are not authorized")
      end
    end
  end
end
