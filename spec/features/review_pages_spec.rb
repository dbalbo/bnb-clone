require 'rails_helper'

describe 'adding a review' do
  it "lets a logged in user to add a review to a listing" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    another_user = FactoryGirl.create(:another_user)
    listing = FactoryGirl.create(:listing)
    another_user.listings << listing
    visit listing_path(listing)
    click_on "Add Review"
    fill_in "Text", with: "test review"
    click_on "Submit"
    expect(page).to have_content("test review")
  end

  it "does not let a user add a review unless logged in" do
    user = FactoryGirl.create(:user)
    another_user = FactoryGirl.create(:another_user)
    listing = FactoryGirl.create(:listing)
    another_user.listings << listing
    visit listing_path(listing)
    click_on "Add Review"
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end

describe "editing a review" do
  it "lets a logged in user edit a listing they posted" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    another_user = FactoryGirl.create(:another_user)
    listing = FactoryGirl.create(:listing)
    another_user.listings << listing
    review = FactoryGirl.create(:review)
    user.reviews << review
    listing.reviews << review
    visit listing_path(listing)
    click_on "Edit Review"
    fill_in "Text", with: "test review test"
    click_on "Submit"
    expect(page).to have_content("test review test")
  end

  it "lets an admin edit any review" do
    user = FactoryGirl.create(:user)
    another_user = FactoryGirl.create(:another_user)
    listing = FactoryGirl.create(:listing)
    review = FactoryGirl.create(:review)
    another_user.listings << listing
    listing.reviews << review
    user.reviews << review
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit listing_path(listing)
    click_on "Edit Review"
    fill_in "Text", with: "test review test"
    click_on "Submit"
    expect(page).to have_content "test review test"
  end
end

describe "deleting a review" do
  it "lets a user delete a review they posted" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    another_user = FactoryGirl.create(:another_user)
    listing = FactoryGirl.create(:listing)
    review = FactoryGirl.create(:review)
    another_user.listings << listing
    user.reviews << review
    listing.reviews << review
    visit listing_path(listing)
    click_on "Delete Review"
    expect(page).to have_no_content review.text
  end

  it "lets an admin delete any review" do
    user = FactoryGirl.create(:user)
    listing = FactoryGirl.create(:listing)
    another_user = FactoryGirl.create(:another_user)
    review = FactoryGirl.create(:review)
    another_user.listings << listing
    listing.reviews << review
    user.reviews << review
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit listing_path(listing)
    click_on "Delete Review"
    expect(page).to have_no_content review.text
  end
end
