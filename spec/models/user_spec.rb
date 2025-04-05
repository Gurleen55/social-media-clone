require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:active_relationships).class_name("Relationship").with_foreign_key("follower_id").dependent(:destroy) }
  it { should have_many(:passive_relationships).class_name("Relationship").with_foreign_key("followed_id").dependent(:destroy) }
  it { should have_many(:following).through(:active_relationships).source(:followed) }
  it { should have_many(:followers).through(:passive_relationships).source(:follower) }
  it { should have_many(:posts).dependent(:destroy) }
  describe "#follow and #unfollow and checks if user is following the other user" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    it "follows the other user" do
      expect { user1.follow(user2) }.to change { user1.following.count }.by(1)
      expect(user1.following).to include(user2)
      expect(user2.followers).to include(user1)
    end

    it "unfollows the other user" do
      user1.follow(user2)
      expect { user1.unfollow(user2) }.to change { user1.following.count }.by(-1)
      expect(user1.following).not_to include(user2)
      expect(user2.followers).not_to include(user1)
    end

    it "checks if user is following the other user" do
      user1.follow(user2)
      expect(user1.following?(user2)).to be_truthy
    end
  end
end
