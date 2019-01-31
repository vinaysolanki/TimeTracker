require "rails_helper"

RSpec.describe "Time Tracker", :type => :system do
  before do
    Capybara.current_driver = :selenium
  end

  describe "Registration Process" do
    it "allows me to sign up with name and email" do
      visit "/users/sign_up"

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("You have signed up successfully.")
    end

    it "allows me to log out after signing up" do
      visit "/users/sign_up"

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("You have signed up successfully.")

      click_link("Logout")

      expect(page).to have_text("You need to sign in")
      expect(page).to have_button("Log in")
    end

    it "enables me to log in and log out" do
      visit "/users/sign_up"

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("You have signed up successfully.")

      click_link("Logout")

      expect(page).to have_text("You need to sign in")
      expect(page).to have_button("Log in")

      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      click_button "Log in"

      expect(page).to have_text("Signed in successfully.")
    end

    it "does not allow me to sign up with an existing email" do
      visit "/users/sign_up"

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("You have signed up successfully.")

      click_link("Logout")

      expect(page).to have_text("You need to sign in")
      expect(page).to have_button("Log in")

      click_link("Sign up")

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("Email has already been taken")
    end

    it "does not allow me to sign up without a name" do
      visit "/users/sign_up"

      fill_in "Name", :with => ""
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Sign up"

      expect(page).to have_text("Name can't be blank")
    end

    it "does not allow me to sign up with a less than 6 character password" do
      visit "/users/sign_up"

      fill_in "Name", :with => "Dave Ramsay"
      fill_in "Email", :with => "daveramsay@gmail.com"
      fill_in "Password", :with => "12345"
      fill_in "Password confirmation", :with => "12345"
      click_button "Sign up"

      expect(page).to have_text("Password is too short")
    end
  end

  describe "Time Tracker Functionality" do
    context "User is logged in" do
      it "allows you to start a timer and track time" do
        visit "/users/sign_up"

        fill_in "Name", :with => "Dave Ramsay"
        fill_in "Email", :with => "daveramsay@gmail.com"
        fill_in "Password", :with => "123456"
        fill_in "Password confirmation", :with => "123456"
        click_button "Sign up"

        expect(page).to have_text("You have signed up successfully.")

        click_button("Start")
        start_time = Time.now.utc

        sleep(3)

        click_button("Stop")
        stop_time = Time.now.utc

        expect(page).to have_text("00:00:03")
        expect(find(".time-sheet-entry:nth-child(1)").text).to include("#{(start_time).strftime('%l:%M:%S')}")
        expect(find(".time-sheet-entry:nth-child(2)").text).to include("#{(stop_time).strftime('%l:%M:%S')}")
        expect(find(".time-sheet-entry:nth-child(3)").text).to include("00:00:03")
      end
    end
  end
end