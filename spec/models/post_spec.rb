require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user)  { User.create!(username: "Tester", email: "test@test.com", password: "passowrd") }
  let(:post) { Post.create!(title: "Title", user: user) }

  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }

  describe "attributes" do
    it "has a title and user attributes" do
      expect(post).to have_attributes(title: "Title", user: user)
    end
  end
end
