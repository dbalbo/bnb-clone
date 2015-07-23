require "rails_helper"

describe "adding a listing" do
  it "lets a logged in user add a listing" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "List Your Space"
    fill_in "Name", with: "test lawn"
    fill_in "Location", with: "portland"
    click_on "Submit"
    # fill_in "search_string", with: "portland"
    # find("#search_string").native.send_keys(:return)
    expect(page).to have_content("test lawn")
  end

  it "doesn't let a user add a listing without logging in" do
    user = FactoryGirl.create(:user)
    visit new_listing_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  it "shows an error if a create listing fails" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    click_on "List Your Space"
    fill_in "Name", with: ""
    click_on "Submit"
    expect(page).to have_content("There was an error")
  end

end

describe "editing a listing" do
  it "lets a logged in user edit a listing they posted" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    listing = FactoryGirl.create(:listing)
    user.listings << listing
    visit listing_path(listing)
    click_on "Edit Listing"
    fill_in "Location", with: "eugene"
    click_on "Submit"
    expect(page).to have_content("eugene")
  end

  it "lets an admin edit any listing" do
    user = FactoryGirl.create(:user)
    listing = FactoryGirl.create(:listing)
    user.listings << listing
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit listing_path(listing)
    click_on "Edit Listing"
    fill_in "Name", with: "test name"
    click_on "Submit"
    expect(page).to have_content "test name"
  end
end

describe "deleting a listing" do
  it "lets a user delete a listing they posted" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    listing = FactoryGirl.create(:listing)
    user.listings << listing
    visit listing_path(listing)
    click_on "Delete Listing"
    expect(page).to have_no_content listing.name
  end

  it "lets an admin delete any listing" do
    user = FactoryGirl.create(:user)
    listing = FactoryGirl.create(:listing)
    user.listings << listing
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit listing_path(listing)
    click_on "Delete Listing"
    expect(page).to have_no_content listing.name
  end
end
