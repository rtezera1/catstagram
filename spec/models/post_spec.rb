require 'spec_helper'

describe Post do 
  it { should belong_to :user }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should_not have_valid(:image).when(nil, '') }

  it { should have_valid(:description).when(nil, '', ('a'*140)) } 
   #invalid if text is more than 140 characters
  it { should_not have_valid(:description).when("a"*141) }

  it { should have_many(:meows).dependent(:destroy) }
end

# this will test the order of the post
describe ".by_recency" do
  it "orders the posts by most recent first" do
    oldest = FactoryGirl.create(:post, created_at: Time.now - 3.days)
    newest = FactoryGirl.create(:post, created_at: Time.now - 1.day)
    middle = FactoryGirl.create(:post, created_at: Time.now - 2.days)

    expect(Post.by_recency).to eq [newest, middle, oldest]
  end
end

describe '#has_meow_from?' do 
  it 'returns true if given user has already created a meow for post' do 
    user = FactoryGirl.create(:user)
    meow = FactoryGirl.create(:meow, user: user, post: post)

    expect(post).to have_meow_from user 
  end

  it 'returns false if given user has not already created a meow for post' do 
    user = FactoryGirl.create(:user)
    meow = FactoryGirl.create(:meow, post: post)

    expect(post).to_not have_meow_from user 
  end
end

describe '#meow_from' do 
  context 'User has a Meow for given Post' do 
    it 'returns that instance of Meow' do 
      meow = FactoryGirl.create(:meow)
      post = meow.post 
      user = meow.user
      expect(post.meow_from(user)).to eq meow
    end
  end

  context "User doesn't have a Meow for given Post" do 
    it "returns nil" do 
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)

      expect(post.meow_from(user)).to eq nil
    end
  end
end



